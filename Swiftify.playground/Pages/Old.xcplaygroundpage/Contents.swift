//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

import SwiftyJSON
import Swiftify

// Enable infinite execution
// So that we can get asynchronously the response
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: Import application data from JSON

/*
 The JSON with app's configuration located in 'Resources/application.json'
 Create it and fill it with your Spotify developer app registered data
 {
    "client_id": "your client id",
    "client_secret": "your client secret key",
    "redirect_uri": "your redirect uri"
 }
 */
let applicationJsonURL = Bundle.main.url(forResource: "application", withExtension: "json")

// MARK: Import token data from JSON

/*
 The JSON with token data in 'Resources/token'
 Create it and fill it with your token data.
 You can let the app get the token data and have it printed for you
 by setting 'hasAuthToken' to false and pasting the authorization code
 in 'authorizationCode' below
 {
    "access_token": "your access token",
	"expires_in": "your expire time (usually 3600)",
	"refresh_token": "your refresh token",
	"token_type": "your token type (usually Bearer)"
 }
 */
let tokenJsonURL = Bundle.main.url(forResource: "token", withExtension: "json")

let swiftify = SwiftifyHelper(with: applicationJsonURL, tokenJsonURL)

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

let hasAuthCode = authorizationCode != ""
let hasToken    = swiftify.hasToken
let shouldAuth  = !(hasAuthCode||hasToken)

if !shouldAuth {
    // Save the token
    if !hasToken { swiftify.saveToken(from: authorizationCode) }
    
    swiftify.refreshToken { refreshed in
        print("Token refreshed: \(refreshed)")
    }
    
    // MARK: Library interaction demo
    
    // Save the track
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        swiftify.save(trackId: "3C3cr2JQwXIhqAHqOardVO") { saved in
            print("Saved: \(saved)")
        }
    }
    
    // Check if the track is saved
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
        swiftify.isSaved(trackId: "3C3cr2JQwXIhqAHqOardVO") { isSaved in
            print("Is saved: \(isSaved)")
        }
    }
    
    // Delete the track
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
        swiftify.delete(trackId: "3C3cr2JQwXIhqAHqOardVO") { deleted in
            print("Deleted: \(deleted)")
        }
    }
    
    // Print first 10 playlists from user library
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
        swiftify.library(.playlist) { results in
            guard let playlists = results as? [SpotifyPlaylist] else { return }
            
            for playlist in playlists {
                print("URI: \(playlist.uri), " +
                      "Name: \(playlist.name)")
            }
        }
    }
    
    // Print tracks in an album
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
        swiftify.tracks(in: .album, "6akEvsycLGftJxYudPjmqK") { tracks in
            for track in tracks {
                print("Name: \(track.name)")
            }
        }
    }
    
    // Print tracks in a playlist
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
        swiftify.tracks(in: .playlist, "5FJXhjdILmRA2z5bvz4nzf", userId: "spotify") { tracks in
            for track in tracks {
                print("Name: \(track.name)")
            }
        }
    }
} else {
    // Authorization
    swiftify.authorize()
}
