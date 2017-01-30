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
}

public struct SpotifyAlbum {
    public var uri:    String
    public var name:   String
}

public struct SpotifyArtist {
    public var uri:    String
    public var name:   String
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
    public func find(_ type: SpotifyQueryType, keyword: String, completionHandler: @escaping ([Any]) -> Void) {
        Alamofire.request(searchQuery(for: type, keyword)).responseJSON { response in
            guard let response = response.result.value else { return }
            
            var results: [Any] = []
         
            let json = JSON(response)
            
            for (_, item) : (String, JSON) in json[type.rawValue + "s"]["items"] {
                switch type {
                case .track:
                    results.append(SpotifyTrack(uri: item["uri"].stringValue,
                                               name: item["name"].stringValue,
                                               album: SpotifyAlbum(uri: item["album"]["uri"].stringValue,
                                                                   name: item["album"]["name"].stringValue),
                                               artist: SpotifyArtist(uri: item["artists"][0]["uri"].stringValue,
                                                                     name: item["artists"][0]["name"].stringValue)))
                case .album:
                    results.append(SpotifyAlbum(uri: item["uri"].stringValue, name: item["name"].stringValue))
                case .artist:
                    results.append(SpotifyArtist(uri: item["uri"].stringValue, name: item["name"].stringValue))
                }
            }
            
            completionHandler(results)
        }
    }
    
    // MARK: Helper functions
    
    /**
     Builds a search query URL for a track on Spotify
     */
    func searchQuery(for type: SpotifyQueryType, _ keyword: String) -> String {
        let keyword = keyword.replacingOccurrences(of: " ", with: "+")
        
        return "https://api.spotify.com/v1/search?q=\(keyword))&type=\(type.rawValue)"
    }
    
}
