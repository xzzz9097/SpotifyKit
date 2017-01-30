//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

import Swiftify

// Enable infinite execution
// So that we can get asynchronously the response
PlaygroundPage.current.needsIndefiniteExecution = true

let swiftify = SwiftifyHelper.shared

// The search keyword
let keyword = "holding you"

swiftify.find(track: keyword) { tracks in
    for track in tracks {
        print("URI: \(track.uri), " +
              "Name: \(track.name), " +
              "Artist: \(track.artist.name), " +
              "Album: \(track.album.name)")
    }
}

