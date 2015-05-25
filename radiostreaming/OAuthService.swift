//
//  OAuthService.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/8/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit

class OAuthService: DataProviderContract{
    
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
    
    func checkConnectivity(success: (response: NSDictionary?)->Void){
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        print("checking \(app.remoteHostStatus?.value)")
        if (app.remoteHostStatus?.value == NotReachable.value){
            success(response: nil)
        }else{
            success(response: ["status_code" : 200])
        }
    }
    
    func run(success: (response: NSDictionary)->Void){
        
        let url = NSURL(string: "api/access_token", relativeToURL: self.apiURL)
        
        let body:NSDictionary = ["grant_type"       : self.grant_type,
            "client_id"        : self.client_id,
            "client_secret"    : self.client_secret]
        
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "POST"
        
        request.timeoutInterval = 10
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var error: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: nil, error: &error)

        
        if(error == nil){
        
            let task = self.session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
                let responseHeaders = response as! NSHTTPURLResponse

                if (responseHeaders.statusCode == 200){

                    var jsonError: NSErrorPointer = NSErrorPointer()
                    
                    if let jsonDecoded = NSJSONSerialization.JSONObjectWithData(data , options: nil, error: jsonError) as? NSDictionary{

                        self.defaults.setValue(jsonDecoded["access_token"], forKey: "access_token")
                        success(response: ["access_token" : jsonDecoded["access_token"]!])
                    
                    }
                }else if (responseHeaders.statusCode == 401) {
                    
                }
            })
            
            task.resume()
        
        }
    }
    
    func getAccessToken()->String?{
        if let token = self.defaults.stringForKey("access_token"){
            return token
        }
        return nil
    }

    func get(resource: String, callback: (result: NSData?, error: NSDictionary?)->Void){
        let url = NSURL(string: resource, relativeToURL: self.apiURL)
        
        let getRequest = NSMutableURLRequest(URL: url!)
        // The access_token exits
        if let access_token: NSString = self.defaults.valueForKey("access_token") as? NSString{

            getRequest.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
            let task = self.session.dataTaskWithRequest(getRequest, completionHandler: { (data, response, error) -> Void in
                callback(result: data, error: nil)
            })
            task.resume()
            
        }else{
            callback(result: nil, error: ["reason": "The access token is not present"])
        }
    }
    
}
