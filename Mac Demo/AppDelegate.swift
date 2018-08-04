//
//  AppDelegate.swift
//  Mac Demo
//
//  Created by Marco Albera on 16/09/2017.
//

import Cocoa
import SpotifyKit

fileprivate enum Action: String {
    case get
    case search
}

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBAction func authorize(_ sender: Any) {
        spotifyManager.authorize()
    }
    
    @IBAction func deauthorize(_ sender: Any) {
        spotifyManager.deauthorize()
    }
    
    @IBOutlet weak var actionMenu: NSPopUpButton!
    
    @IBOutlet weak var kindMenu: NSPopUpButton!
    
    @IBOutlet weak var textField: NSTextField!
    
    @IBOutlet var consoleView: NSTextView!
    
    @IBOutlet weak var window: NSWindow!
    
    let spotifyManager = SpotifyManager(with:
        SpotifyManager.SpotifyDeveloperApplication(
            clientId:     "64961bd35af24dd4862ae29e0a8f5caa",
            clientSecret: "8d6ec5ba180b4114b4212bcd618bf6ad",
            redirectUri:  "swiftifymac://callback"
        )
    )
    
    @IBAction func run(_ sender: Any) {
        switch actionMenu.indexOfSelectedItem {
        case 0:
            switch kindMenu.indexOfSelectedItem {
            case 0:
                get(SpotifyTrack.self, id: textField.stringValue)
            case 1:
                get(SpotifyArtist.self, id: textField.stringValue)
            case 2:
                get(SpotifyAlbum.self, id: textField.stringValue)
            case 3:
                get(SpotifyPlaylist.self, id: textField.stringValue)
            default: break
            }
        case 1:
            switch kindMenu.indexOfSelectedItem {
            case 0:
                find(SpotifyTrack.self, textField.stringValue)
            case 1:
                find(SpotifyArtist.self, textField.stringValue)
            case 2:
                find(SpotifyAlbum.self, textField.stringValue)
            case 3:
                find(SpotifyPlaylist.self, textField.stringValue)
            default: break
            }
        default: break
        }
    }
    
    func prepareViews() {
        [actionMenu, kindMenu].forEach { $0?.removeAllItems() }
        
        actionMenu.addItems(withTitles: [Action.get.rawValue,
                                         Action.search.rawValue])
        
        kindMenu.addItems(withTitles: [SpotifyItemType.track.rawValue,
                                       SpotifyItemType.artist.rawValue,
                                       SpotifyItemType.album.rawValue,
                                       SpotifyItemType.playlist.rawValue])
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        initEventManager()
        
        prepareViews()
        
        spotifyManager.authorize()
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            //self.find(SpotifyTrack.self, "concrete heartbeat")
            //self.library(SpotifyPlaylist.self)
            //self.get(SpotifyAlbum.self, id: "4IKyYu9zNndBVpi8FoekaS")
            //self.isSaved("5FTCKvxzqy72ceS4Ujux4N")
            //self.save("5FTCKvxzqy72ceS4Ujux4N")
        //}
    }
    
    func applicationWillTerminate(_ aNotification: Notification) { }
    
    // MARK: URL handling
    
    func initEventManager() {
        NSAppleEventManager.shared().setEventHandler(self,
                                                     andSelector: #selector(handleURLEvent),
                                                     forEventClass: AEEventClass(kInternetEventClass),
                                                     andEventID: AEEventID(kAEGetURL))
    }
    
    /**
     Catches URLs with specific prefix ("muse://")
     */
    @objc func handleURLEvent(event: NSAppleEventDescriptor,
                              replyEvent: NSAppleEventDescriptor) {
        if  let descriptor = event.paramDescriptor(forKeyword: keyDirectObject),
            let urlString  = descriptor.stringValue,
            let url        = URL(string: urlString) {
            spotifyManager.saveToken(from: url)
        }
    }
    
    // MARK: Swiftify features implementation
    
    func get<T>(_ type: T.Type, id: String) where T: SpotifySearchItem {
        spotifyManager.get(type, id: id) { [weak self] result in
            
            self?.consoleView.string = "\(result.name) - ID: \(result.id), URI: \(result.uri)"
        }
    }
    
    func find<T>(_ type: T.Type, _ keyword: String) where T: SpotifySearchItem {
        spotifyManager.find(type, keyword) { [weak self] result in
            self?.consoleView.string = result.reduce(into: "", { (result, item) in
                result += "\(item.name) - ID: \(item.id), URI: \(item.uri) \n"
            })
        }
    }
    
    func library<T>(_ type: T.Type) where T: SpotifyLibraryItem {
        spotifyManager.library(type) { [weak self] result in
            self?.consoleView.string = result.reduce(into: "", { (result, item) in
                result += "\(item.name) - ID: \(item.id), URI: \(item.uri) \n"
            })
        }
    }
    
    func isSaved(_ trackId: String) {
        spotifyManager.isSaved(trackId: trackId) { [weak self] saved in
            self?.consoleView.string = "Track \(trackId) saved: \(saved)"
        }
    }
    
    func save(_ trackId: String) {
        spotifyManager.save(trackId: trackId) { [weak self] saved in
            self?.consoleView.string =  "Track \(trackId) saved: \(saved)"
        }
    }
    
    func delete(_ trackId: String) {
        spotifyManager.delete(trackId: trackId) { [weak self] saved in
            self?.consoleView.string = "Track \(trackId) deleted: \(saved)"
        }
    }
}
