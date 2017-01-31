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

enum SpotifyQuery: String {
    case search = "https://api.spotify.com/v1/search"
    
    public var url: URLConvertible {
        return self.rawValue as URLConvertible
    }
}

public enum SpotifyQueryType: String {
    case track  = "track"
    case album  = "album"
    case artist = "artist"
}

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
    
    // MARK: Singleton constructor
    
    public static let shared = SwiftifyHelper()
    
    private init() { }
    
    // MARK: Query functions
    
    /**
     Finds tracks on Spotify that match a provided keyword
     - parameter track: the track name
     - parameter completionHandler: the block to run when results
        are found and passed as parameter to it
     */
    public func find(_ type: SpotifyQueryType, _ keyword: String, completionHandler: @escaping ([Any]) -> Void) {
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
    
    // MARK: Helper functions
    
    /**
     Builds search query parameters for an element on Spotify
     */
    func searchParameters(for type: SpotifyQueryType, _ keyword: String) -> Parameters {
        return ["q": keyword, "type": type.rawValue]
    }
    
}
