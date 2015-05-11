//
//  OAuthService.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/8/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit

class OAuthService{
    let client_id: NSString
    let client_secret: NSString
    let apiURL = NSURL(string: "http://radioproezas.app")
    let session = NSURLSession.sharedSession()
    let grant_type: NSString
    let defaults = NSUserDefaults.standardUserDefaults()
   
    init(){
        //Insecure for production. Hide id and secret.
        self.client_id = "HgPcsQZMNbs4k7Jcwgd3YutTHaNeb91oEJiYtoK0"
        self.client_secret = "2G3RfjMRqJLGNOibiG5DgA0BbY0nVWpxRbly42Si"
        self.grant_type = "client_credentials"
    }
    
    func getAccessToken(callback: (result: AnyObject)->Void ){

        let url = NSURL(string: "api/access_token", relativeToURL: self.apiURL)
        let request = NSMutableURLRequest(URL: url!)
        let body:NSDictionary = ["grant_type"       : self.grant_type,
                                 "client_id"        : self.client_id,
                                 "client_secret"    : self.client_secret]
        self.postRequest(request, data: body, callback: callback)
    }
    // Asynch postRequest
    func postRequest(request: NSMutableURLRequest, data: NSDictionary, callback: (result: AnyObject)->Void)
    {
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var error: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: &error)
        let task = self.session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            callback(result: data)
        })
        task.resume()
    }
    func getRequest(resource: String, callback: (result: AnyObject)->Void)
    {
        let url = NSURL(string: resource, relativeToURL: self.apiURL)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
    
        let token = self.defaults.stringForKey("access_token")

        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")

        var error: NSError
        let task = self.session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            let res = NSJSONSerialization.JSONObjectWithData(data, options: nil , error: nil) as! NSDictionary
            callback(result: res)
        })
        task.resume()
    }
}
