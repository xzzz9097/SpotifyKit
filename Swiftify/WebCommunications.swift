//
//  WebCommunications.swift
//  Swiftify
//
//  Created by Marco Albera on 21/09/2017.
//

import Foundation

enum HTTPRequestMethod: String {
    
    case GET, POST, PUT, DELETE
}

fileprivate enum HTTPResponseStatusCode: Int {
    
    case OK = 200
}

typealias HTTPRequestParameters = [String: Any]
typealias HTTPRequestHeaders    = [String: String]

extension Dictionary where Key == String {
    
    var httpCompatible: String {
        return String(
            self.reduce("") { "\($0)&\($1.key)=\($1.value)" }
                .replacingOccurrences(of: " ", with: "+")
                .dropFirst()
        )
    }
}

extension URLSession {
    
    func request(_ url: URL?,
                        method: HTTPRequestMethod = .GET,
                        parameters: HTTPRequestParameters? = nil,
                        headers: HTTPRequestHeaders? = nil,
                        completionHandler: @escaping (Data?) -> ()) {
        guard let url = url else { return }
        
        var request = URLRequest(url: url)
        
        // Configure the request
        request.allHTTPHeaderFields = headers
        request.httpMethod          = method.rawValue

        if let parameters = parameters {
            request.url = URL(string: "\(url.absoluteString)?\(parameters.httpCompatible)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, 
            error in
            var success = false
            
            if let response = response as? HTTPURLResponse {
                if case HTTPResponseStatusCode.OK.rawValue = response.statusCode {
                    success = true
                }
            }
            
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async { completionHandler(data) }
            }
        }
        
        task.resume()
    }
    
    func request(_ rawUrl: String,
                        method: HTTPRequestMethod = .GET,
                        parameters: HTTPRequestParameters? = nil,
                        headers: HTTPRequestHeaders? = nil,
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
