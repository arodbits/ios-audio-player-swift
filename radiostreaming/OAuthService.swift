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
    let client_id: String
    let client_secret: String
    let apiURL = NSURL(string: "radioproezas.app/api")
    let session = NSURLSession?()
    
    init(){
        self.client_id = "HgPcsQZMNbs4k7Jcwgd3YutTHaNeb91oEJiYtoK0"
        self.client_secret = "2G3RfjMRqJLGNOibiG5DgA0BbY0nVWpxRbly42Si"
    }
    
    func getAccessToken(){
        
    }

}
