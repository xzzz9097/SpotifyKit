# SpotifyKit
A Swift client for Spotify's Web API.

[![Build Status](https://travis-ci.org/xzzz9097/SpotifyKit.svg?branch=master)](https://travis-ci.org/xzzz9097/SpotifyKit)
[![Version](https://img.shields.io/cocoapods/v/SpotifyKit.svg?style=flat)](http://cocoapods.org/pods/SpotifyKit)
[![License](https://img.shields.io/cocoapods/l/SpotifyKit.svg?style=flat)](http://cocoapods.org/pods/SpotifyKit)
[![Platform](https://img.shields.io/cocoapods/p/SpotifyKit.svg?style=flat)](http://cocoapods.org/pods/SpotifyKit)

## Installation
SpotifyKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SpotifyKit"
```

## Initialization
You can easily create a SpotifyKit helper object by providing your Spotify application data.
```swift
let spotifyManager = SpotifyManager(with:
    SpotifyManager.SpotifyDeveloperApplication(
        clientId:     "client_id",
        clientSecret: "client_secret",
        redirectUri:  "redirect_uri"
    )
)
```
The token data gathered at authentication moment is automatically saved in a secure preference with Keychain.

## Authentication
This is arguably the trickiest step. At your app launch, you should call authorization method like this:
```swift
spotifyManager.authorize()
```
It sends a request of authorization for the user's account, that will result in a HTTP response with the specified URL prefix and the authorization code as parameter.
The method automatically skips the process if a saved token is found.

Then, in order to complete authentication and obtain the token, you must setup a URL scheme (in Info.plist file of your app) and catch the code like this:
### iOS
```swift
// MARK: in your AppDelegate.swift file

/**
 Catches URLs with specific prefix ("your_spotify_redirect_uri://")
 */
func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
    spotifyManager.saveToken(from: url)

    return true
}
```
### MacOS
```swift
/**
 Registers the URL watcher
 */
NSAppleEventManager.shared().setEventHandler(self,
    andSelector: #selector(handleURLEvent),
    forEventClass: AEEventClass(kInternetEventClass),
    andEventID: AEEventID(kAEGetURL))

/**
 Catches URLs with specific prefix ("your_spotify_redirect_uri://")
 */
func handleURLEvent(event: NSAppleEventDescriptor,
                    replyEvent: NSAppleEventDescriptor) {
	if	let descriptor = event.paramDescriptor(forKeyword: keyDirectObject),
		let urlString  = descriptor.stringValue,
		let url        = URL(string: urlString) {
		spotifyManager.saveToken(from: url)
	}
}
```
Now SpotifyKit is fully authenticated with your user account and you can use all the methods it provides.

## Usage
All methods send HTTP request through URLSession API and report the results with simple callbacks
### Find
Finds tracks (as in this example), albums or artists in Spotify database:
```swift
// Signature
public func find<T>(_ what: T.Type,
                    _ keyword: String,
                    completionHandler: @escaping ([T]) -> Void) where T: SpotifySearchItem

// Example
spotifyManager.find(SpotifyTrack.self, "track_title") { tracks in
	// Tracks is a [SpotifyTrack] array
	for track in tracks {
        print("URI:    \(track.uri), "         +
              "Name:   \(track.name), "        +
              "Artist: \(track.artist.name), " +
              "Album:  \(track.album.name)")
    }
}
```
get() and library() functions are also available for retrieving a specific item or fetching your library's tracks, albums or playlists.

### User library interaction
Save, delete and check saved status for tracks in "Your Music" playlist
```swift
// Save the track
spotifyManager.save(trackId: "track_id") { saved in
    print("Saved: \(saved)")
}

// Check if the track is saved
spotifyManager.isSaved(trackId: "track_id") { isSaved in
    print("Is saved: \(isSaved)")
}

// Delete the track
spotifyManager.delete(trackId: "track_id") { deleted in
    print("Deleted: \(deleted)")
}
```

## Supported Spotify items
The items are automatically decoded from JSON, by conforming to Swift 4 "Decodable" protocol.
### Generic item
The protocol which is inherited by all items, including common properties
```swift
public protocol SpotifyItem: Decodable {

	var id:   String { get }
	var uri:  String { get }
	var name: String { get }
}

public protocol SpotifySearchItem: SpotifyItem {
	// Items conforming to this protocol can be searched
}

public protocol SpotifyLibraryItem: SpotifyItem {
	// Items conforming to this protocol can be contained in user's library
}
```
### User
```swift
public struct SpotifyUser: SpotifySearchItem {

	public var email:  String?

	// URI of the user profile picture
	public var artUri: String
}
```
### Track
```swift
public struct SpotifyTrack: SpotifySearchItem, SpotifyLibraryItem {

	public var album:  SpotifyAlbum?
	public var artist: SpotifyArtist
}
```
### Album
```swift
public struct SpotifyAlbum: SpotifySearchItem, SpotifyLibraryItem, SpotifyTrackCollection {

	// The tracks contained in the album
	public var collectionTracks: [SpotifyTrack]?

	public var artist: SpotifyArtist

	// The album's cover image
	public var artUri: String
}
```
### Playlist
```swift
public struct SpotifyPlaylist: SpotifySearchItem, SpotifyLibraryItem, SpotifyTrackCollection {

	// The tracks contained in the playlist
	public var collectionTracks: [SpotifyTrack]?
}
```
### Artist
```swift
public struct SpotifyArtist: SpotifySearchItem {
	// Artist has no additional properties
}
```

## Examples
- iOS and macOS sample projects are available in this repository
- [Muse](https://github.com/xzzz9097/Muse)
