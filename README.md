## Swiftify
A Swift client for Spotify's Web API.

## Setup
### JSON data
You must setup two JSON files in your project: one for app authentication, to be filled with your developer data, and one for token saving, that will automatically be compiled.
```json
{
	"client_id": "",
	"client_secret": "",
	"redirect_uri": ""
}
```

```json
{
  "refresh_token" : "",
  "token_type" : "",
  "access_token" : "",
  "expires_in" : 3600
}
```
Once you've added the files to your project, load them like this:
```swift
let applicationJsonURL = Bundle.main.url(forResource: "application", withExtension: "json")

let tokenJsonURL = Bundle.main.url(forResource: "token", withExtension: "json")
```

### Initialization
```swift
let swiftify = SwiftifyHelper(with: applicationJsonURL, tokenJsonURL)
```
Swiftify can also be initialized without token files (it won't write your token for permanent saving) or even with no application file, allowing only generic queries and no account-related operations.

### Authentication
This is arguably the trickiest step. The command:
```swift
swiftify.authorize()
```
sends a request of authorization for the user's account, that will result in a HTTP response with the specified URL prefix and the authorization code as parameter. Then, you can manually copy and paste the code:
```swift
swiftify.saveToken(from: authorizationCode)
```
 or, if you're in a proper app project, setup a URL scheme and catch the code like this:
```swift
/**
 Registers the URL watcher
 */
NSAppleEventManager.shared().setEventHandler(self,
    andSelector: #selector(handleURLEvent),
    forEventClass: AEEventClass(kInternetEventClass),
    andEventID: AEEventID(kAEGetURL))

/**
 Catches URLs with specific prefix ("muse://")
 */
func handleURLEvent(event: NSAppleEventDescriptor,
                    replyEvent: NSAppleEventDescriptor) {
    if  let urlDescriptor = event.paramDescriptor(forKeyword: keyDirectObject),
        let urlString     = urlDescriptor.stringValue,
        let urlComponents = URLComponents(string: urlString),
        let queryItems    = (urlComponents.queryItems as [NSURLQueryItem]?) {
            // Get "code=" parameter from URL
            // https://gist.github.com/gillesdemey/509bb8a1a8c576ea215a
            let code = queryItems.filter({ (item) in item.name == "code" }).first?.value!

            // Send it to Swiftify
            swiftify.saveToken(from: code)
        }
}
```

## Usage
All methods send HTTP request through Alamofire API and report the results with simple callbacks
### Search
Finds tracks (as in this example), albums or artists in Spotify database, without requiring user authorization:
```swift
swiftify.find(.track, "track_title") { results in
    guard let tracks = results as? [SpotifyTrack] else { return }

    for track in tracks {
        print("URI:    \(track.uri), "         +
              "Name:   \(track.name), "        +
              "Artist: \(track.artist.name), " +
              "Album:  \(track.album.name)")
    }
}
```

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
