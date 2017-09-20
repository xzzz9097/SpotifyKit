//
//  Swiftify.swift
//  Swiftify
//
//  Created by Marco Albera on 30/01/17.
//
//

import Cocoa

import Alamofire

// MARK: Token saving options

enum TokenSavingMethod {
    case preference
}

// MARK: Spotify queries addresses

/**
 Parameter names for Spotify HTTP requests
 */
fileprivate struct SpotifyParameter {
    // Search
    static let name = "q"
    static let type = "type"
    
    // Authorization
    static let clientId     = "client_id"
    static let responseType = "response_type"
    static let redirectUri  = "redirect_uri"
    static let scope        = "scope"
    
    // Token
    static let clientSecret = "client_secret"
    static let grantType    = "grant_type"
    static let code         = "code"
    static let refreshToken = "refresh_token"
    
    // User's library
    static let ids          = "ids"
}

/**
 Header names for Spotify HTTP requests
 */
fileprivate struct SpotifyHeader {
    // Authorization
    static let authorization = "Authorization"
}

// MARK: Queries data types

/**
 URLs for Spotify HTTP queries
 */
fileprivate enum SpotifyQuery: String, URLConvertible {
    func asURL() throws -> URL {
        switch self {
        case .master, .account:
            return URL(string: self.rawValue)!
        case .search, .users, .me, .contains:
            return URL(string: SpotifyQuery.master.rawValue + self.rawValue)!
        case .authorize, .token:
            return URL(string: SpotifyQuery.account.rawValue + self.rawValue)!
        }
    }
    
    // Master URLs
    case master  = "https://api.spotify.com/v1/"
    case account = "https://accounts.spotify.com/"
    
    // Search
    case search = "search"
    case users  = "users"
    
    // Authentication
    case authorize = "authorize"
    case token     = "api/token"
    
    // User's library
    case me        = "me/"
    case contains  = "me/tracks/contains"
    
    static func libraryUrlFor<T>(_ what: T.Type) -> URLConvertible where T: SpotifyLibraryItem {
        return master.rawValue + me.rawValue + what.type.searchKey.rawValue
    }
    
    static func urlFor<T>(_ what: T.Type,
                          id: String,
                          playlistUserId: String? = nil) -> URLConvertible where T: SpotifySearchItem {
        switch what.type {
        case .track, .album, .artist:
            return master.rawValue + what.type.searchKey.rawValue + "/\(id)"
        case .playlist:
            guard let userId = playlistUserId else { return "" }
            return users.rawValue + "/\(userId)/playlists/\(id)"
        }
    }
}

/**
 Scopes (aka permissions) required by our app
 during authorization phase
 // TODO: test this more
 */
fileprivate enum SpotifyScope: String {
    case readPrivate   = "user-read-private"
    case readEmail     = "user-read-email"
    case libraryModify = "user-library-modify"
    case libraryRead   = "user-library-read"
    
    /**
     Creates a string to pass as parameter value
     with desired scope keys
     */
    static func string(with scopes: [SpotifyScope]) -> String {
        var string = ""
        
        for scope in scopes {
            // Add the selected scopes
            string += "\(scope.rawValue) "
        }
        
        // Delete last space character
        return String(string[..<string.index(before: string.endIndex)])
    }
}

fileprivate enum SpotifyAuthorizationResponseType: String {
    case code = "code"
}

fileprivate enum SpotifyAuthorizationType: String {
    case basic  = "Basic "
    case bearer = "Bearer "
}

/**
 Spotify authentication grant types for obtaining token
 */
fileprivate enum SpotifyTokenGrantType: String {
    case authorizationCode = "authorization_code"
    case refreshToken      = "refresh_token"
}

// MARK: Helper class

public class SwiftifyHelper {
    
    public struct SpotifyDeveloperApplication {
        var clientId:     String
        var clientSecret: String
        var redirectUri:  String
        
        public init(clientId:     String,
                    clientSecret: String,
                    redirectUri:  String) {
            self.clientId     = clientId
            self.clientSecret = clientSecret
            self.redirectUri  = redirectUri
        }
    }
    
    @objc(Swiftify)private class SpotifyToken: NSObject, Decodable, NSCoding {
        var accessToken:  String
        var expiresIn:    Int
        var refreshToken: String
        var tokenType:    String
        
        var saveTime: TimeInterval
        
        static let preferenceKey = "spotifyToken"
        
        // MARK: Decodable
        
        enum Key: String, CodingKey {
            case access_token, expires_in, refresh_token, token_type, save_time
        }
        
        convenience required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Key.self)
            
            self.init(
                accessToken: try? container.decode(String.self, forKey: .access_token),
                expiresIn: try? container.decode(Int.self, forKey: .expires_in),
                refreshToken: try? container.decode(String.self, forKey: .refresh_token),
                tokenType: try? container.decode(String.self, forKey: .token_type)
            )
        }
        
        // MARK: NSCoding
        
        func encode(with coder: NSCoder) {
            coder.encode(accessToken, forKey: Key.access_token.rawValue)
            coder.encode(expiresIn, forKey: Key.expires_in.rawValue)
            coder.encode(refreshToken, forKey: Key.refresh_token.rawValue)
            coder.encode(tokenType, forKey: Key.token_type.rawValue)
            coder.encode(saveTime, forKey: Key.save_time.rawValue)
        }
        
        required convenience init?(coder decoder: NSCoder) {
            self.init(
                accessToken:  decoder.decodeObject(forKey: Key.access_token.rawValue) as? String,
                expiresIn:    decoder.decodeInteger(forKey: Key.expires_in.rawValue),
                refreshToken: decoder.decodeObject(forKey: Key.refresh_token.rawValue) as? String,
                tokenType:    decoder.decodeObject(forKey: Key.token_type.rawValue) as? String,
                saveTime:     decoder.decodeObject(forKey: Key.save_time.rawValue) as? TimeInterval
            )
        }
        
        // MARK: Other
        
        required init(accessToken:  String?,
                      expiresIn:    Int?,
                      refreshToken: String?,
                      tokenType:    String?,
                      saveTime:     TimeInterval? = nil) {
            self.accessToken  = accessToken ?? ""
            self.expiresIn    = expiresIn ?? 0
            self.refreshToken = refreshToken ?? ""
            self.tokenType    = tokenType ?? ""
            self.saveTime     = saveTime ?? Date.timeIntervalSinceReferenceDate
        }
        
        /**
         Writes the contents of the token to a preference.
         */
        func writeToKeychain() {
            Keychain.standard.set(self, forKey: SpotifyToken.preferenceKey)
        }
        
        /**
         Loads the token object from a preference.
         */
        static func loadFromKeychain() -> SpotifyToken? {
            return Keychain.standard.value(forKey: SpotifyToken.preferenceKey) as? SpotifyToken
        }
        
        /**
         Updates a token from a JSON, for instance after calling 'refreshToken',
         when only a new 'accessToken' is provided
         */
        func refresh(from data: Data) {
            guard let token = try? JSONDecoder().decode(SpotifyToken.self,
                                                        from: data) else { return }
            
            accessToken = token.accessToken
            saveTime     = Date.timeIntervalSinceReferenceDate
        }
        
        /**
         Returns whether a token is expired basing on saving time,
         current time and provided duration limit
         */
        var isExpired: Bool {
            return Date.timeIntervalSinceReferenceDate - saveTime > Double(expiresIn)
        }
        
        /**
         Returns true if the token is valid (aka not blank)
         */
        var isValid: Bool {
            return !self.accessToken.isEmpty && !self.refreshToken.isEmpty && !self.tokenType.isEmpty && self.expiresIn != 0
        }
        
        var details: NSString {
            return  """
            Access token:  \(accessToken)
            Expires in:    \(expiresIn)
            Refresh token: \(refreshToken)
            Token type:    \(tokenType)
            """ as NSString
        }
    }
    
    private var application: SpotifyDeveloperApplication?
    
    private var tokenSavingMethod: TokenSavingMethod = .preference
    
    private var applicationJsonURL: URL?
    
    private var token: SpotifyToken?
    
    private var tokenJsonURL: URL?
    
    // MARK: Constructors
    
    public static let shared = SwiftifyHelper()
    
    private init() { }
    
    public init(with application: SpotifyDeveloperApplication) {
        self.application = application
        
        if let token = SpotifyToken.loadFromKeychain() {
            self.token = token
        }
    }
    
    // MARK: Query functions
    
    private func tokenQuery(operation: @escaping (SpotifyToken) -> ()) {
        guard let token = self.token else { return }
        
        guard !token.isExpired else {
            // If the token is expired, refresh it first
            // Then try repeating the operation
            refreshToken { refreshed in
                if refreshed {
                    operation(token)
                }
            }
            
            return
        }
        
        // Run the requested query operation
        operation(token)
    }

    /**
     Gets a specific Spotify item (track, album, artist or playlist
     - parameter what: the type of the item ('SpotifyTrack', 'SpotifyAlbum'...)
     - parameter id: the item Spotify identifier
     - parameter playlistUserId: the id of the user who owns the requested playlist
     - parameter completionHandler: the block to run when result is found and passed as parameter to it
     */
    public func get<T>(_ what: T.Type,
                       id: String,
                       playlistUserId: String? = nil,
                       completionHandler: @escaping ((T) -> Void)) where T: SpotifySearchItem {
        tokenQuery { token in
            Alamofire.request(SpotifyQuery.urlFor(what,
                                                  id: id,
                                                  playlistUserId: playlistUserId),
                              method: .get,
                              headers: self.authorizationHeader(with: token))
                .responseJSON { response in
                    guard let data = response.data else { return }
                    
                    if let parsedResult = try? JSONDecoder().decode(what,
                                                                    from: data) {
                        completionHandler(parsedResult)
                    }
            }
        }
    }
    
    /**
     Finds items on Spotify that match a provided keyword
     - parameter what: the type of the item ('SpotifyTrack', 'SpotifyAlbum'...)
     - parameter keyword: the item name
     - parameter completionHandler: the block to run when results
     are found and passed as parameter to it
     */
    public func find<T>(_ what: T.Type,
                        _ keyword: String,
                        completionHandler: @escaping ([T]) -> Void) where T: SpotifySearchItem {
        tokenQuery { token in
            Alamofire.request(SpotifyQuery.search,
                              method: .get,
                              parameters: self.searchParameters(for: what.type, keyword),
                              headers: self.authorizationHeader(with: token))
                .responseJSON { response in
                    guard let data = response.data else { return }
                    
                    let parsedResults = try? JSONDecoder().decode(SpotifyFindResponse<T>.self, from: data).results.items
                    
                    if let parsedResults = parsedResults {
                        completionHandler(parsedResults)
                    }
            }
        }
    }
    
    /**
     Finds the first track on Spotify matching search results for
     - parameter title: the title of the track
     - parameter artist: the artist of the track
     - parameter completionHandler: the handler that is executed with the track as parameter
     */
    func getTrack(title: String,
                  artist: String,
                  completionHandler: @escaping (SpotifyTrack) -> Void) {
        find(SpotifyTrack.self, "\(title) \(artist)") { results in
            if let track = results.first {
                completionHandler(track)
            }
        }
    }
    
    // MARK: Authorization
    
    /**
     Retrieves the authorization code with user interaction
     Note: this only opens the browser window with the proper request,
     you then have to manually copy the 'code' from the opened url
     and insert it to get the actual token
     */
    public func authorize() {
        guard let application = application else { return }
        
        Alamofire.request(SpotifyQuery.authorize,
                          method: .get,
                          parameters: authorizationParameters(for: application))
            .response { response in
                if let request = response.request, let url = request.url {
                    NSWorkspace.shared.open(url)
                }
        }
    }
    
    /**
     Retrieves the token from the authorization code and saves it locally
     - parameter authorizationCode: the code received from Spotify redirected uri
     */
    public func saveToken(from authorizationCode: String) {
        guard let application = application else { return }
        
        Alamofire.request(SpotifyQuery.token,
                          method: .post,
                          parameters: tokenParameters(for: application,
                                                      from: authorizationCode))
            .validate().responseJSON { response in
                if response.result.isSuccess {
                    self.token = self.generateToken(from: response)
                    
                    // Prints the token for debug
                    if let token = self.token {
                        debugPrint(token.details)
                        
                        switch self.tokenSavingMethod {
                        case .preference:
                            token.writeToKeychain()
                        }
                    }
                }
        }
    }
    
    /**
     Generates a token from values provided by the user
     - parameters: the token data
     */
    public func saveToken(accessToken:  String,
                          expiresIn:    Int,
                          refreshToken: String,
                          tokenType:    String) {
        self.token = SpotifyToken(accessToken: accessToken,
                                  expiresIn: expiresIn,
                                  refreshToken: refreshToken,
                                  tokenType: tokenType)
        
        // Prints the token for debug
        if let token = self.token { debugPrint(token.details) }
    }
    
    /**
     Returns if the helper is currently holding a token
     */
    public var hasToken: Bool {
        guard let token = token else { return false }
        
        // Only return true if the token is actually valid
        return token.isValid
    }
    
    /**
     Refreshes the token when expired
     */
    public func refreshToken(completionHandler: @escaping (Bool) -> Void) {
        guard let application = application, let token = self.token else { return }
        
        Alamofire.request(SpotifyQuery.token,
                          method: .post,
                          parameters: refreshTokenParameters(from: token),
                          headers: refreshTokenHeaders(for: application))
            .validate().responseJSON { response in
                completionHandler(response.result.isSuccess)
                
                if response.result.isSuccess {
                    guard let data = response.data else { return }
                    
                    // Refresh current token
                    // Only 'accessToken' needs to be changed
                    // guard is not really needed here because we checked before
                    self.token?.refresh(from: data)
                    
                    // Prints the token for debug
                    if let token = self.token { debugPrint(token.details) }
                }
        }
    }
    
    // MARK: User library interaction
    
    /**
     Gets the first saved tracks/albums/playlists in user's library
     - parameter type: .track, .album or .playlist
     - parameter completionHandler: the callback to run, passes the tracks array
     as argument
     // TODO: read more than 20/10 items
     */
    public func library<T>(_ what: T.Type,
                           completionHandler: @escaping ([T]) -> Void) where T: SpotifyLibraryItem {
        tokenQuery { token in
            Alamofire.request(SpotifyQuery.libraryUrlFor(what),
                              method: .get,
                              headers: self.authorizationHeader(with: token))
                .responseJSON { response in
                    guard let data = response.data else { return }
                    
                    let parsedResults = try? JSONDecoder().decode(SpotifyLibraryResponse<T>.self, from: data).items
                    
                    if let parsedResults = parsedResults {
                        completionHandler(parsedResults)
                    }
            }
        }
    }
    
    /**
     Saves a track to user's "Your Music" library
     - parameter trackId: the id of the track to save
     - parameter completionHandler: the callback to execute after response,
     brings the saving success as parameter
     */
    public func save(trackId: String,
                     completionHandler: @escaping (Bool) -> Void) {
        tokenQuery { token in
            Alamofire.request(SpotifyQuery.libraryUrlFor(SpotifyTrack.self),
                              method: .put,
                              parameters: self.trackIdsParameters(for: trackId),
                              encoding: URLEncoding(destination: .queryString),
                              headers: self.authorizationHeader(with: token))
                .validate().responseData { response in
                    completionHandler(response.result.isSuccess)
            }
        }
    }
    
    /**
     Saves a track to user's "Your Music" library
     - parameter track: the 'SpotifyTrack' object to save
     - parameter completionHandler: the callback to execute after response,
     brings the saving success as parameter
     */
    public func save(track: SpotifyTrack,
                     completionHandler: @escaping (Bool) -> Void) {
        save(trackId: track.id, completionHandler: completionHandler)
    }
    
    /**
     Deletes a track from user's "Your Music" library
     - parameter trackId: the id of the track to save
     - parameter completionHandler: the callback to execute after response,
     brings the deletion success as parameter
     */
    public func delete(trackId: String,
                       completionHandler: @escaping (Bool) -> Void) {
        tokenQuery { token in
            Alamofire.request(SpotifyQuery.libraryUrlFor(SpotifyTrack.self),
                              method: .delete,
                              parameters: self.trackIdsParameters(for: trackId),
                              encoding: URLEncoding(destination: .queryString),
                              headers: self.authorizationHeader(with: token))
                .validate().responseData { response in
                    completionHandler(response.result.isSuccess)
            }
        }
    }
    
    /**
     Deletes a track from user's "Your Music" library
     - parameter track: the 'SpotifyTrack' object to save
     - parameter completionHandler: the callback to execute after response,
     brings the deletion success as parameter
     */
    public func delete(track: SpotifyTrack,
                       completionHandler: @escaping (Bool) -> Void) {
        delete(trackId: track.id, completionHandler: completionHandler)
    }
    
    /**
     Checks if a track is saved into user's "Your Music" library
     - parameter track: the id of the track to check
     - parameter completionHandler: the callback to execute after response,
     brings 'isSaved' as parameter
     */
    public func isSaved(trackId: String,
                        completionHandler: @escaping (Bool) -> Void) {
        tokenQuery { token in
            Alamofire.request(SpotifyQuery.contains,
                              method: .get,
                              parameters: self.trackIdsParameters(for: trackId),
                              headers: self.authorizationHeader(with: token))
                .responseJSON { response in
                    guard let data = response.data else { return }
                    
                    // Sends the 'isSaved' value back to the completion handler
                    if  let results = try? JSONDecoder().decode([Bool].self, from: data),
                        let saved = results.first {
                        completionHandler(saved)
                    }
            }
        }
    }
    
    /**
     Checks if a track is saved into user's "Your Music" library
     - parameter track: the 'SpotifyTrack' object to check
     - parameter completionHandler: the callback to execute after response,
     brings 'isSaved' as parameter
     */
    public func isSaved(track: SpotifyTrack,
                        completionHandler: @escaping (Bool) -> Void) {
        isSaved(trackId: track.id, completionHandler: completionHandler)
    }
    
    // MARK: Helper functions
    
    /**
     Builds search query parameters for an element on Spotify
     - return: searchquery parameters
     */
    private func searchParameters(for type: SpotifyItemType,
                                  _ keyword: String) -> Parameters {
        return [SpotifyParameter.name: keyword,
                SpotifyParameter.type: type.rawValue]
    }
    
    /**
     Builds authorization parameters
     */
    private func authorizationParameters(for application: SpotifyDeveloperApplication) -> Parameters {
        return [SpotifyParameter.clientId: application.clientId,
                SpotifyParameter.responseType: SpotifyAuthorizationResponseType.code.rawValue,
                SpotifyParameter.redirectUri: application.redirectUri,
                SpotifyParameter.scope: SpotifyScope.string(with: [.readPrivate, .readEmail, .libraryModify, .libraryRead])]
    }
    
    /**
     Builds token parameters
     - return: parameters for token retrieval
     */
    private func tokenParameters(for application: SpotifyDeveloperApplication,
                                 from authorizationCode: String) -> Parameters {
        return [SpotifyParameter.clientId: application.clientId,
                SpotifyParameter.clientSecret: application.clientSecret,
                SpotifyParameter.grantType: SpotifyTokenGrantType.authorizationCode.rawValue,
                SpotifyParameter.code: authorizationCode,
                SpotifyParameter.redirectUri: application.redirectUri]
    }
    
    /**
     Builds token refresh parameters
     - return: parameters for token refresh
     */
    private func refreshTokenParameters(from oldToken: SpotifyToken) -> Parameters {
        return [SpotifyParameter.grantType: SpotifyTokenGrantType.refreshToken.rawValue,
                SpotifyParameter.refreshToken: oldToken.refreshToken]
    }
    
    /**
     Builds the authorization header for token refresh
     - return: authorization header
     */
    private func refreshTokenHeaders(for application: SpotifyDeveloperApplication) -> HTTPHeaders {
        guard let auth = Request.authorizationHeader(user: application.clientId, password: application.clientSecret) else { return [:] }
        
        return [auth.key: auth.value]
    }
    
    /**
     Builds the authorization header for user library interactions
     - return: authorization header
     */
    private func authorizationHeader(with token: SpotifyToken) -> HTTPHeaders {
        return [SpotifyHeader.authorization: SpotifyAuthorizationType.bearer.rawValue +
            token.accessToken]
    }
    
    /**
     Builds parameters for saving a track into user's library
     - return: parameters for track saving
     */
    private func trackIdsParameters(for trackId: String) -> Parameters {
        return [SpotifyParameter.ids: trackId]
    }
    
    /**
     Generates a 'SpotifyToken' from a JSON response
     - return: the 'SpotifyToken' object
     */
    private func generateToken(from response: DataResponse<Any>) -> SpotifyToken? {
        guard let data = response.data else { return nil }
        
        return try? JSONDecoder().decode(SpotifyToken.self, from: data)
    }
    
}
