//: Playground - noun: a place where people can play

import Cocoa
import Alamofire
import PlaygroundSupport

// Enable infinite execution
// So that we can get asynchronously the response
PlaygroundPage.current.needsIndefiniteExecution = true

struct Response {
    var request:  URLRequest?
    var response: HTTPURLResponse?
    var error:    Error?
}

var aResponse = Response(request: nil, response: nil, error: nil)

Alamofire.request("https://httpbin.org/get").responseJSON { response in    
    aResponse = Response(request: response.request,
                         response: response.response,
                         error: response.error)
    
    if let json = response.result.value {
        print("JSON: \(json)")
    }
}