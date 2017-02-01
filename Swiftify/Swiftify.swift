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
}

// MARK: Queries data types

/**
 URLs for Spotify HTTP queries
 */
fileprivate enum SpotifyQuery: String {
    case search    = "https://api.spotify.com/v1/search"
    case authorize = "https://accounts.spotify.com/authorize"
    case token     = "https://accounts.spotify.com/api/token"
    
    public var url: URLConvertible {
        return self.rawValue as URLConvertible
    }
}

fileprivate enum SpotifyAuthorizationResponseType: String {
    case code = "code"
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
    public var uri:    String
    public var name:   String
    public var album:  SpotifyAlbum
    public var artist: SpotifyArtist
    
    init(from item: JSON) {
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
        
        public init(clientId: String, clientSecret: String, redirectUri: String) {
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
        
        init(from item: JSON) {
            self.accessToken  = item["access_token"].stringValue
            self.expiresIn    = item["expires_in"].intValue
            self.refreshToken = item["refresh_token"].stringValue
            self.tokenType    = item["token_type"].stringValue
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
    public func find(_ type: SpotifySearchType, _ keyword: String, completionHandler: @escaping ([Any]) -> Void) {
        Alamofire.request(SpotifyQuery.search.url, method: .get, parameters: searchParameters(for: type, keyword)).responseJSON { response in
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
        
        Alamofire.request(SpotifyQuery.authorize.url, method: .get, parameters: authorizationParameters(for: application)).response { response in
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
        
        Alamofire.request(SpotifyQuery.token.url, method: .post, parameters: tokenParameters(for: application, from: authorizationCode)).responseJSON { response in
            self.token = self.generateToken(from: response)
            
            if let token = self.token { print(token.accessToken) }
        }
    }
    
    /**
     Refreshes the token when expired
     */
    public func refreshToken() {
        guard let application = application, let token = self.token else { return }
        
        Alamofire.request(SpotifyQuery.token.url, method: .post, parameters: refreshTokenParameters(for: application, from: token)).responseJSON { response in
            self.token = self.generateToken(from: response)
            
            if let token = self.token { print(token.accessToken) }
        }
    }
    
    // MARK: Helper functions
    
    /**
     Builds search query parameters for an element on Spotify
     - return: searchquery parameters
     */
    private func searchParameters(for type: SpotifySearchType, _ keyword: String) -> Parameters {
        return [.name: keyword, .type: type.rawValue]
    }
    
    /**
     Builds authorization parameters
     */
    private func authorizationParameters(for application: SpotifyDeveloperApplication) -> Parameters {
        return [.clientId: application.clientId,
                .responseType: SpotifyAuthorizationResponseType.code.rawValue,
                .redirectUri: application.redirectUri,
                .scope: "user-read-private user-read-email"]
    }
    
    /**
     Builds token parameters
     - return: parameters for token retrieval
     */
    private func tokenParameters(for application: SpotifyDeveloperApplication, from authorizationCode: String) -> Parameters {
        return [.clientId: application.clientId,
                .clientSecret: application.clientSecret,
                .grantType: SpotifyTokenGrantType.authorizationCode.rawValue,
                .code: authorizationCode,
                .redirectUri: application.redirectUri]
    }
    
    /**
     Builds token reshresh parameters
     - return: parameters for token refresh
     */
    private func refreshTokenParameters(for application: SpotifyDeveloperApplication, from oldToken: SpotifyToken) -> Parameters {
        return [.grantType: SpotifyTokenGrantType.refreshToken.rawValue,
                .refreshToken: oldToken.refreshToken]
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
