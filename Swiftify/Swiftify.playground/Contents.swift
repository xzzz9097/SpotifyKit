//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

import Swiftify

// Enable infinite execution
// So that we can get asynchronously the response
PlaygroundPage.current.needsIndefiniteExecution = true

let swiftify = SwiftifyHelper.shared

// The search keyword
var keyword = "holding you"

swiftify.find(.track, keyword) { results in
    guard let tracks = results as? [SpotifyTrack] else { return }
    
    for track in tracks {
        print("URI: \(track.uri), " +
              "Name: \(track.name), " +
              "Artist: \(track.artist.name), " +
              "Album: \(track.album.name)")
    }
}

keyword = "vessels"

swiftify.find(.album, keyword) { results in
    guard let albums = results as? [SpotifyAlbum] else { return }
    
    for album in albums {
        print("URI: \(album.uri), " +
              "Name: \(album.name), " +
              "Artist: \(album.artist.name)")
    }
}

keyword = "the lost electric"

swiftify.find(.artist, keyword) { results in
    guard let artists = results as? [SpotifyArtist] else { return }
    
    for artist in artists {
        print("URI: \(artist.uri), " +
              "Name: \(artist.name)")
    }
}