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
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        print(url)
        
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

}

