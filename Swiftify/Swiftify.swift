//
//  Swiftify.swift
//  Swiftify
//
//  Created by Marco Albera on 30/01/17.
//
//

import Cocoa

import Alamofire
import SwiftyJSON

/**
 Parameter names for Spotify HTTP requests
 */
fileprivate extension String {
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
    static let authorization = "Authorization"
    static let ids           = "ids"
}

// MARK: Queries data types

/**
 URLs for Spotify HTTP queries
 */
fileprivate enum SpotifyQuery: String {
    // Search
    case search    = "https://api.spotify.com/v1/search"
    
    // Authentication
    case authorize = "https://accounts.spotify.com/authorize"
    case token     = "https://accounts.spotify.com/api/token"
    
    // User's library
    case tracks    = "https://api.spotify.com/v1/me/tracks"
    case contains  = "https://api.spotify.com/v1/me/tracks/contains"
    
    public var url: URLConvertible {
        return self.rawValue as URLConvertible
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

/**
 Item type for Spotify search query
 */
public enum SpotifySearchType: String {
    case track  = "track"
    case album  = "album"
    case artist = "artist"
}

// MARK: Items data types

public struct SpotifyTrack {
    public var id:     String
    public var uri:    String
    public var name:   String
    public var album:  SpotifyAlbum
    public var artist: SpotifyArtist
    
    init(from item: JSON) {
        self.id     = item["id"].stringValue
        self.uri    = item["uri"].stringValue
        self.name   = item["name"].stringValue
        self.album  = SpotifyAlbum(from: item["album"])
        self.artist = SpotifyArtist(from: item["artists"][0])
    }
}

public struct SpotifyAlbum {
    public var uri:    String
    public var name:   String
    public var artist: SpotifyArtist
    
    init(from item: JSON) {
        self.uri    = item["uri"].stringValue
        self.name   = item["name"].stringValue
        self.artist = SpotifyArtist(from: item["artists"][0])
    }
}

public struct SpotifyArtist {
    public var uri:    String
    public var name:   String
    
    init(from item: JSON) {
        self.uri    = item["uri"].stringValue
        self.name   = item["name"].stringValue
    }
}

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
    
    private struct SpotifyToken {
        var accessToken:  String
        var expiresIn:    Int
        var refreshToken: String
        var tokenType:    String
        var saveTime:     TimeInterval
        
        init(accessToken:  String,
             expiresIn:    Int,
             refreshToken: String,
             tokenType:    String) {
            self.accessToken  = accessToken
            self.expiresIn    = expiresIn
            self.refreshToken = refreshToken
            self.tokenType    = tokenType
            self.saveTime     = Date.timeIntervalSinceReferenceDate
        }
        
        init(from item: JSON) {
            self.init(accessToken:  item["access_token"].stringValue,
                      expiresIn:    item["expires_in"].intValue,
                      refreshToken: item["refresh_token"].stringValue,
                      tokenType:    item["token_type"].stringValue)
        }
        
        /**
         Returns whether a token is expired basing on saving time,
         current time and provided duration limit
         */
        var isExpired: Bool {
            return Date.timeIntervalSinceReferenceDate - saveTime > Double(expiresIn)
        }
    }
    
    private var application: SpotifyDeveloperApplication?
    
    private var token: SpotifyToken?
    
    // MARK: Constructors
    
    public static let shared = SwiftifyHelper()
    
    private init() { }
    
    public init(with application: SpotifyDeveloperApplication) {
        self.application = application
    }
    
    // MARK: Query functions
    
    /**
     Finds tracks on Spotify that match a provided keyword
     - parameter track: the track name
     - parameter completionHandler: the block to run when results
        are found and passed as parameter to it
     */
    public func find(_ type: SpotifySearchType,
                     _ keyword: String, completionHandler: @escaping ([Any]) -> Void) {
        Alamofire.request(SpotifyQuery.search.url,
                          method: .get,
                          parameters: searchParameters(for: type, keyword))
            .responseJSON { response in
            guard let response = response.result.value else { return }
            
            var results: [Any] = []
         
            let json = JSON(response)
            
            for (_, item) : (String, JSON) in json[type.rawValue + "s"]["items"] {
                switch type {
                case .track:
                    results.append(SpotifyTrack(from: item))
                case .album:
                    results.append(SpotifyAlbum(from: item))
                case .artist:
                    results.append(SpotifyArtist(from: item))
                }
            }
            
            completionHandler(results)
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
        
        Alamofire.request(SpotifyQuery.authorize.url,
                          method: .get,
                          parameters: authorizationParameters(for: application))
            .response { response in
            if let request = response.request, let url = request.url {
                NSWorkspace.shared().open(url)
            }
        }
    }
    
    /**
     Retrieves the token from the authorization code and saves it locally
     - parameter authorizationCode: the code received from Spotify redirected uri
     */
    public func saveToken(from authorizationCode: String) {
        guard let application = application else { return }
        
        Alamofire.request(SpotifyQuery.token.url,
                          method: .post,
                          parameters: tokenParameters(for: application,
                                                      from: authorizationCode))
            .validate().responseJSON { response in
            if response.result.isSuccess {
                self.token = self.generateToken(from: response)
                
                // Prints the token for debug
                print(self.token)
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
        print(self.token)
    }
    
    /**
     Returns if the helper is currently holding a token
     */
    public var hasToken: Bool {
        return token != nil
    }
    
    /**
     Refreshes the token when expired
     */
    public func refreshToken(completionHandler: @escaping (Bool) -> Void) {
        guard let application = application, let token = self.token else { return }
        
        Alamofire.request(SpotifyQuery.token.url,
                          method: .post,
                          parameters: refreshTokenParameters(from: token),
                          headers: refreshTokenHeaders(for: application))
            .validate().responseJSON { response in
            completionHandler(response.result.isSuccess)
            
            if response.result.isSuccess {
                self.token = self.generateToken(from: response)
            }
        }
    }
    
    // MARK: User library interaction
    
    /**
     Saves a track to user's "Your Music" library
     - parameter trackId: the id of the track to save
     - parameter completionHandler: the callback to execute after response,
                                    brings the saving success as parameter
     */
    public func save(trackId: String,
                     completionHandler: @escaping (Bool) -> Void) {
        guard let token = token else { return }
        
        Alamofire.request(SpotifyQuery.tracks.url,
                          method: .put,
                          parameters: trackIdsParameters(for: trackId),
                          encoding: URLEncoding(destination: .queryString),
                          headers: authorizationHeader(with: token))
            .validate().responseData { response in
            completionHandler(response.result.isSuccess)
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
        guard let token = token else { return }
        
        Alamofire.request(SpotifyQuery.tracks.url,
                          method: .delete,
                          parameters: trackIdsParameters(for: trackId),
                          encoding: URLEncoding(destination: .queryString),
                          headers: authorizationHeader(with: token))
            .validate().responseData { response in
            completionHandler(response.result.isSuccess)
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
        guard let token = token else { return }
        
        Alamofire.request(SpotifyQuery.contains.url,
                          method: .get,
                          parameters: trackIdsParameters(for: trackId),
                          headers: authorizationHeader(with: token))
            .responseJSON { response in
            guard let value = response.result.value else { return }
            
            // Sends the 'isSaved' value back to the completion handler
            completionHandler(JSON(value)[0].boolValue)
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
    private func searchParameters(for type: SpotifySearchType,
                                  _ keyword: String) -> Parameters {
        return [.name: keyword, .type: type.rawValue]
    }
    
    /**
     Builds authorization parameters
     */
    private func authorizationParameters(for application: SpotifyDeveloperApplication) -> Parameters {
        return [.clientId: application.clientId,
                .responseType: SpotifyAuthorizationResponseType.code.rawValue,
                .redirectUri: application.redirectUri,
                .scope: "user-read-private user-read-email user-library-modify user-library-read"]
    }
    
    /**
     Builds token parameters
     - return: parameters for token retrieval
     */
    private func tokenParameters(for application: SpotifyDeveloperApplication,
                                 from authorizationCode: String) -> Parameters {
        return [.clientId: application.clientId,
                .clientSecret: application.clientSecret,
                .grantType: SpotifyTokenGrantType.authorizationCode.rawValue,
                .code: authorizationCode,
                .redirectUri: application.redirectUri]
    }
    
    /**
     Builds token refresh parameters
     - return: parameters for token refresh
     */
    private func refreshTokenParameters(from oldToken: SpotifyToken) -> Parameters {
        return [.grantType: SpotifyTokenGrantType.refreshToken.rawValue,
                .refreshToken: oldToken.refreshToken]
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
        return [.authorization: SpotifyAuthorizationType.bearer.rawValue +
                                token.accessToken]
    }
    
    /**
     Builds parameters for saving a track into user's library
     - return: parameters for track saving
     */
    private func trackIdsParameters(for trackId: String) -> Parameters {
        return [.ids: trackId]
    }
    
    /**
     Generates a 'SpotifyToken' from a JSON response
     - return: the 'SpotifyToken' object
     */
    private func generateToken(from response: DataResponse<Any>) -> SpotifyToken? {
        guard let response = response.result.value else { return nil }
        
        let json = JSON(response)
        
        return SpotifyToken(from: json)
    }
    
}
