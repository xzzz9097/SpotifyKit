//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

import SwiftyJSON
import Swiftify

// Enable infinite execution
// So that we can get asynchronously the response
PlaygroundPage.current.needsIndefiniteExecution = true

/*
 The JSON with app's configuration located in 'Resources/application.json'
 Create it and fill it with your Spotify developer app registered data
 {
    "client_id": "your client id",
    "client_secret": "your client secret key",
    "redirect_uri": "your redirect uri"
 }
 */
let json = try JSON(Data(contentsOf: Bundle.main.url(forResource: "application", withExtension: "json")!))

// The registered Spotify developer application
let application = SwiftifyHelper.SpotifyDeveloperApplication(
    clientId:     json["client_id"].stringValue,
    clientSecret: json["client_secret"].stringValue,
    redirectUri:  json["redirect_uri"].stringValue)

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
    
    // Save the track
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        swiftify.save(trackId: "3C3cr2JQwXIhqAHqOardVO")
    }
    
    // Check if the track is saved
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
        swiftify.isSaved(trackId: "3C3cr2JQwXIhqAHqOardVO") { saved in
            print("Saved: \(saved)")
        }
    }
} else {
    // Authorization
    swiftify.authorize()
}
