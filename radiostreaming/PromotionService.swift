//
//  PromotionService.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/11/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit

class PromotionService{
 
    let service = OAuthService()
    
    func all(callback: (promotions: NSDictionary)->Void){
        service.getRequest("api/promotions") { (result) -> Void in
            var error: NSError?
            callback(promotions: result as! NSDictionary)
        }
    }
    
    func find(id: Int){
      
    }
    
}