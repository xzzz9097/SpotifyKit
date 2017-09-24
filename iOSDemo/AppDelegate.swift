//
//  AppDelegate.swift
//  iOSDemo
//
//  Created by Marco Albera on 24/09/2017.
//

import UIKit

// Import Swiftify iOS library
import Swiftify

// MARK: Swiftify initialization

// The Spotify developer application object
// Fill this with the data from the app you've set up on Spotify developer page
fileprivate let application = SwiftifyHelper.SpotifyDeveloperApplication(
    clientId:     "3c13957ca82a45158ad7854aef9778e4",
    clientSecret: "77f7e2109e0340a384d5745df2043d66",
    redirectUri:  "swiftifyios://callback"
)

// The Swiftify helper object that will allow you to perform the queries
let swiftify = SwiftifyHelper(with: application)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: URL event handling
    
    /**
     After sending 'swiftify.authorize()' command,
     our application receives an URL starting with the "redirect uri" we've set up
     in Spotify Developer page and added to our app's Info.plist under "URL types" -> "URL schemes".
     This URI contains the token access code which grants the privileges needed for performing Spotify queries.
     Here we catche the URI as it is passed to our app, retrieve the token code and send it
     to Swifify, which will generate the code and save it in Keychain for persistency
     */
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if  let urlComponents = URLComponents(string: url.absoluteString),
            let queryItems    = urlComponents.queryItems {
            
            // Get "code=" parameter from URL
            // https://gist.github.com/gillesdemey/509bb8a1a8c576ea215a
            let code = queryItems.filter { item in item.name == "code" } .first?.value!
            
            // Send code to Swiftify
            if let authorizationCode = code {
                swiftify.saveToken(from: authorizationCode)
            }
        }
        
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

}

