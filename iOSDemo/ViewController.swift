//
//  ViewController.swift
//  iOSDemo
//
//  Created by Marco Albera on 24/09/2017.
//

import UIKit

// Import Swiftify iOS library
import Swiftify

class ViewController: UIViewController {
    
    // The Spotify developer application object
    // Fill this with the data from the app you've set up on Spotify developer page
    static let application = SwiftifyHelper.SpotifyDeveloperApplication(
        clientId: "3c13957ca82a45158ad7854aef9778e4",
        clientSecret: "77f7e2109e0340a384d5745df2043d66",
        redirectUri: "swiftifyios://callback"
    )
    
    // The Swiftify helper object that will allow you to perform the queries
    let swiftify = SwiftifyHelper(with: application, autoLogin: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swiftify.authorize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

