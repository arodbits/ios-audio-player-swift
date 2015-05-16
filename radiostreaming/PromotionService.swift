//
//  PromotionService.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/11/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit


class PromotionService {
    
    let service: OAuthService
    
    init(){
        self.service = OAuthService()
    }
    
    func all(callback: (result: NSData?, error: NSDictionary?)->Void){
        print("working")
        service.get("api/promotions", callback: callback)
    }
    
    func save(){
        //service.save(promotion)
    }
    
    func update(){
    
    }
    
    func delete(){
    
    }
    
    func find(){
        //service.find('promotion', 'id')
    }
    
}
/*
promotion.all()
*/


/*
MySQL service
--------------

response = mysql.find('table', 'conditions')
mysql.save()


promotions = oauth.all('promotions')
oauth.save('prmotions/create', 'values') 



*/