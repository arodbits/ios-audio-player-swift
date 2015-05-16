//
//  RadioService.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/16/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit

class RadioService{
   
    let dataProvider: OAuthService
    
    init(){
        self.dataProvider = OAuthService()
    }
    
    func find(id: Int, callback: (result: NSData?, error: NSDictionary?)->Void){
        self.dataProvider.get("api/radio/\(id)", callback: callback)
    }
}