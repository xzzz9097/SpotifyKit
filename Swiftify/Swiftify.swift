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

public struct SpotifyTrack {
    public var uri:    String
    public var name:   String
    public var album:  String
    public var artist: String
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
    public func find(track: String, completionHandler: @escaping ([SpotifyTrack]) -> Void) {
        Alamofire.request(searchQuery(for: track)).responseJSON { response in
            guard let result = response.result.value else { return }
            
            var tracks: [SpotifyTrack] = []
         
            let json = JSON(result)
            
            for (_, item) : (String, JSON) in json["tracks"]["items"] {
                tracks.append(SpotifyTrack(uri: item["uri"].stringValue,
                                           name: item["name"].stringValue,
                                           album: item["album"]["name"].stringValue,
                                           artist: item["artists"][0]["name"].stringValue))
            }
            
            completionHandler(tracks)
        }
    }
    
    // MARK: Helper functions
    
    /**
     Builds a search query URL for a track on Spotify
     */
    func searchQuery(for track: String) -> String {
        let keyword = track.replacingOccurrences(of: " ", with: "+")
        
        return "https://api.spotify.com/v1/search?q=\(keyword))&type=track"
    }
    
}
