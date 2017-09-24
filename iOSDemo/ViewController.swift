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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Authorize our app for the Spotify account if there is no token
        // This opens a browser window from which the user can authenticate into his account
        swiftify.authorize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

