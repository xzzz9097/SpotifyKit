//
//  ViewController.swift
//  iOSDemo
//
//  Created by Marco Albera on 24/09/2017.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var userNameLabel:      UILabel!
    @IBOutlet weak var mailLabel:          UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeProfilePictureView()
        
        // Authorize our app for the Spotify account if there is no token
        // This opens a browser window from which the user can authenticate into his account
        spotifyManager.authorize()
        
        loadUser()
    }

    func customizeProfilePictureView() {
        // Add a circular layer around profile picture
        profilePictureView.layer.cornerRadius = profilePictureView.frame.size.width / 2
        profilePictureView.clipsToBounds      = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Load UI
    
    func loadUser() {
        spotifyManager.myProfile { [weak self] profile in
            if let strongSelf = self {
                // Set user name
                strongSelf.userNameLabel.text = profile.name
                
                // Set mail
                strongSelf.mailLabel.text = profile.email ?? ""
                
                // Set image
                if let imageURL = URL(string: profile.artUri) {
                    strongSelf.profilePictureView.download(from: imageURL)
                }
            }
        }
    }

}
