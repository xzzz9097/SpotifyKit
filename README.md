# Swiftify
A Swift client for Spotify's Web API.

## Initialization
You can easily create a Swiftify helper object by providing your Spotify application data.
```swift
let swiftify = SwiftifyHelper(with:
    SwiftifyHelper.SpotifyDeveloperApplication(
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
swiftify.authorize()
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
    swiftify.saveToken(from: url)

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
		swiftify.saveToken(from: url)
	}
}
```
Now Swiftify is fully authenticated with your user account and you can use all the methods it provides.

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
swiftify.find(SpotifyTrack.self, "track_title") { tracks in
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
swiftify.save(trackId: "track_id") { saved in
    print("Saved: \(saved)")
}

// Check if the track is saved
swiftify.isSaved(trackId: "track_id") { isSaved in
    print("Is saved: \(isSaved)")
}

// Delete the track
swiftify.delete(trackId: "track_id") { deleted in
    print("Deleted: \(deleted)")
}
```

## Examples
- [Playground](https://github.com/xzzz9097/Swiftify/blob/master/Swiftify/Swiftify.playground/Contents.swift)
- [Muse](https://github.com/xzzz9097/Muse)
