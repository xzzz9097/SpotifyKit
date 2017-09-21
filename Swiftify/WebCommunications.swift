//
//  WebCommunications.swift
//  Swiftify
//
//  Created by Marco Albera on 21/09/2017.
//

import Foundation

public enum RequestMethod: String {
    
    case GET, POST, PUT, DELETE
}

public typealias RequestParameters = [String: String]
public typealias RequestHeaders    = [String: String]

public extension Dictionary where Key == String {
    
    var httpCompatible: Data? {
        return self.reduce("") { "\($0)&\($1.key)=\($1.value)" } .dropFirst().data(using: .utf8)
    }
}

public extension URLSession {
    
    public func request(_ url: URL,
                        method: RequestMethod = .GET,
                        parameters: RequestParameters? = nil,
                        headers: RequestHeaders? = nil,
                        completionHandler: @escaping (Data?) -> ()) {
        var request = URLRequest(url: url)
        
        // Configure the request
        request.allHTTPHeaderFields = headers
        request.httpMethod          = method.rawValue
        request.httpBody            = parameters?.httpCompatible
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                // Placeholder: handle error
            } else {
                completionHandler(data)
            }
        }
        
        task.resume()
    }
    
    public func request(_ rawUrl: String,
                        method: RequestMethod = .GET,
                        parameters: RequestParameters? = nil,
                        headers: RequestHeaders? = nil,
                        completionHandler: @escaping (Data?) -> ()) {
        if let url = URL(string: rawUrl) {
            request(url,
                    method: method,
                    parameters: parameters,
                    headers: headers,
                    completionHandler: completionHandler)
        }
    }
}
