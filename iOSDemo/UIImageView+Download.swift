//
//  UIImageView+Download.swift
//  iOSDemo
//
//  Created by Marco Albera on 27/09/2017.
//

import UIKit

// MARK: Image downloading

extension UIImageView {
    
    /**
     Downloads an image form the specified URL
     */
    func download(from url: URL,
                  callback: @escaping (UIImage) -> () = { _ in }) {
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url, completionHandler: {
            [weak self] url, response, error in
            
            if error == nil && url != nil {
                if let data = NSData(contentsOf: url!) {
                    if let image = UIImage(data: data as Data) {
                        if let strongSelf = self {
                            DispatchQueue.main.async {
                                // Set downloaded image
                                strongSelf.image = image
                                
                                // Run callback with the downloaded image
                                DispatchQueue.main.async { callback(image) }
                            }
                        }
                    }
                }
            }
        })
        
        downloadTask.resume()
    }
}
