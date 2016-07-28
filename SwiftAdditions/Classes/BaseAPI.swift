//
//  BaseAPI.swift
//  F45 Playbook
//
//  Created by Robert Dougan on 02/06/16.
//  Copyright © 2016 Robert Dougan. All rights reserved.
//

import Foundation

public class BaseAPI: NSObject, NSURLSessionDataDelegate, NSURLSessionTaskDelegate {
    
    public var session: NSURLSession {
        return NSURLSession(configuration: self.sessionConfiguration, delegate: self, delegateQueue: nil)
    }
    
    public var sessionConfiguration: NSURLSessionConfiguration {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        return configuration
    }
    
    // MARK: Requests
    
    // GET
    
    public func get(url: NSURL, completionHandler: (success: Bool, JSON: AnyObject?, error: NSError?) -> Void) {
        self.get(url, parameters: nil, completionHandler: completionHandler)
    }
    
    public func get(url: NSURL, parameters: [String: AnyObject]?, completionHandler: (success: Bool, JSON: AnyObject?, error: NSError?) -> Void) {
        self.perform("GET", url: url, parameters: parameters, completionHandler: completionHandler)
    }
    
    // POST
    
    public func post(url: NSURL, completionHandler: (success: Bool, JSON: AnyObject?, error: NSError?) -> Void) {
        self.post(url, parameters: nil, completionHandler: completionHandler)
    }
    
    public func post(url: NSURL, parameters: [String: AnyObject]?, completionHandler: (success: Bool, JSON: AnyObject?, error: NSError?) -> Void) {
        self.perform("POST", url: url, parameters: parameters, completionHandler: completionHandler)
    }
    
    // PUT
    
    public func put(url: NSURL, completionHandler: (success: Bool, JSON: AnyObject?, error: NSError?) -> Void) {
        self.put(url, parameters: nil, completionHandler: completionHandler)
    }
    
    public func put(url: NSURL, parameters: [String: AnyObject]?, completionHandler: (success: Bool, JSON: AnyObject?, error: NSError?) -> Void) {
        self.perform("PUT", url: url, parameters: parameters, completionHandler: completionHandler)
    }
    
    // DELETE
    
    public func delete(url: NSURL, completionHandler: (success: Bool, JSON: AnyObject?, error: NSError?) -> Void) {
        self.delete(url, parameters: nil, completionHandler: completionHandler)
    }
    
    public func delete(url: NSURL, parameters: [String: AnyObject]?, completionHandler: (success: Bool, JSON: AnyObject?, error: NSError?) -> Void) {
        self.perform("DELETE", url: url, parameters: parameters, completionHandler: completionHandler)
    }
    
    public func perform(method: String, url: NSURL, parameters: [String: AnyObject]?, completionHandler: (success: Bool, JSON: AnyObject?, error: NSError?) -> Void) {
        var params = [String: AnyObject]()
        if (parameters != nil) {
            params = parameters!
        }
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = method
        
        if (method == "GET") {
            let parameterString = params.stringFromHttpParameters()
            request.URL = NSURL(string: "\(url)?\(parameterString)")!
        }
        else {
            request.URL = url
        }
        
        if ((method == "POST" || method == "PUT") && parameters != nil) {
            let json = try! NSJSONSerialization.dataWithJSONObject(parameters!, options: NSJSONWritingOptions())
            request.HTTPBody = json
        }
        
        func handler(data: NSData?, response: NSURLResponse?, error: NSError?) {
            if let _ = response as? NSHTTPURLResponse {
                let JSON = try? NSJSONSerialization.JSONObjectWithData(data!, options: [])
//                var error = error
                
                self.mainThread {
                    if (error == nil) {
                        completionHandler(success: true, JSON: JSON, error: nil)
                    }
                    else {
                        completionHandler(success: false, JSON: JSON, error: error)
                    }
                }
            }
            else {
                completionHandler(success: false, JSON: nil, error: error)
            }
        }
        
        let task = self.session.dataTaskWithRequest(request) { data, response, error in
            RWDActivityManager.sharedInstance.subtract()
            
            handler(data, response: response, error: error)
        }
        
        task.resume()
        
        RWDActivityManager.sharedInstance.append()
    }
    
    public func mainThread(block: (Void) -> Void) {
        {} ~> {
            block()
        }
    }
    
}