//
//  OAuthApi.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/12/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit

class OAuthApi{
    
    func getAccessToken()->String?{
        if let token = self.defaults.stringForKey("access_token"){
            return token
        }
        return nil
    }
    
    func get(){
        
    }
    
    func post(){
        
    }
}