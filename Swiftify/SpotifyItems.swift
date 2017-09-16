//
//  SpotifyItems.swift
//  Swiftify
//
//  Created by Marco Albera on 16/09/2017.
//

import Foundation
import SwiftyJSON

/**
 Item type for Spotify search query
 */
public enum SpotifyItemType: String {
    case track, album, artist, playlist
}

// MARK: Items data types

public protocol SpotifyItem: Decodable {
    var id:     String { set get }
    var uri:    String { set get }
    var name:   String { set get }
    
    static var type:   SpotifyItemType { get }
}

public struct SpotifyTrack: SpotifyItem {
    public var id:     String
    public var uri:    String
    public var name:   String
    public var album:  SpotifyAlbum
    
    public static let type: SpotifyItemType = .track
    
    var artists = [SpotifyArtist]()
    
    public var artist: SpotifyArtist {
        set {
            artists = [newValue]
        }
        
        get {
            return artists.first!
        }
    }
    
    init(from item: JSON) {
        self.id     = item["id"].stringValue
        self.uri    = item["uri"].stringValue
        self.name   = item["name"].stringValue
        self.album  = SpotifyAlbum(from: item["album"])
        self.artist = SpotifyArtist(from: item["artists"][0])
    }
}

public struct SpotifyAlbum: SpotifyItem {
    struct Image: Decodable {
        var url: String
    }
    
    public var id:     String
    public var uri:    String
    public var name:   String
    
    public static let type: SpotifyItemType = .album
    
    var images  = [Image]()
    var artists = [SpotifyArtist]()
    
    public var artist: SpotifyArtist {
        set {
            artists = [newValue]
        }
        
        get {
            return artists.first!
        }
    }
    
    public var artUri: String {
        set {
            images = [Image(url: newValue)]
        }
        
        get {
            return images.first!.url
        }
    }
    
    init(from item: JSON) {
        self.id     = item["id"].stringValue
        self.uri    = item["uri"].stringValue
        self.name   = item["name"].stringValue
        self.artUri = item["images"][0]["url"].stringValue
        self.artist = SpotifyArtist(from: item["artists"][0])
    }
}

public struct SpotifyPlaylist: SpotifyItem {
    public var id:   String
    public var uri:  String
    public var name: String
    
    public static let type: SpotifyItemType = .playlist
    
    init(from item: JSON) {
        self.id     = item["id"].stringValue
        self.uri    = item["uri"].stringValue
        self.name   = item["name"].stringValue
    }
}

public struct SpotifyArtist: SpotifyItem {
    public var id:     String
    public var uri:    String
    public var name:   String
    
    public static let type: SpotifyItemType = .artist
    
    init(from item: JSON) {
        self.id     = item["id"].stringValue
        self.uri    = item["uri"].stringValue
        self.name   = item["name"].stringValue
    }
}

public struct SpotifyFindResponse<T: SpotifyItem> {
    public struct Results: Decodable {
        public var items: [T]
    }
    
    public var results: Results
}

extension SpotifyFindResponse: Decodable {
    enum Keys: String, CodingKey {
        case artists, tracks, albums, playlists
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        var results = Results(items: [])
        
        if let artists = try? container.decode(Results.self, forKey: .artists) {
            results = artists
        } else if let tracks = try? container.decode(Results.self, forKey: .tracks) {
            results = tracks
        } else if let albums = try? container.decode(Results.self, forKey: .albums) {
            results = albums
        } else if let playlists = try? container.decode(Results.self, forKey: .playlists) {
            results = playlists
        }
        
        self.init(results: results)
    }
}
