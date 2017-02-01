//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

import Swiftify

// Enable infinite execution
// So that we can get asynchronously the response
PlaygroundPage.current.needsIndefiniteExecution = true

// The registered Spotify developer application
// Fill the args with your app's data
let application = SwiftifyHelper.SpotifyDeveloperApplication(clientId: "",
                                                             clientSecret: "",
                                                             redirectUri: "")
let swiftify = SwiftifyHelper(with: application)

// MARK: Search demo

swiftify.find(.track, "holding you") { results in
    guard let tracks = results as? [SpotifyTrack] else { return }
    
    for track in tracks {
        print("URI: \(track.uri), " +
            "Name: \(track.name), " +
            "Artist: \(track.artist.name), " +
            "Album: \(track.album.name)")
    }
}

// MARK: Authorization demo

// Fill this var with the string after 'code' in the webpage opened
// after authorize()
let authorizationCode = ""

if authorizationCode != "" {
    // Save the token
    swiftify.saveToken(from: authorizationCode)
} else {
    // Authorization
    swiftify.authorize()
}
