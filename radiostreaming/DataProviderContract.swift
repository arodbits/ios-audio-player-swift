//
//  DataProviderContract.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/17/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit

protocol DataProviderContract{
    func get(resource: String, callback: (result: NSData?, error: NSDictionary?)->Void)
    func run(success: (response: NSDictionary)->Void)
    func checkConnectivity(success: (response: NSDictionary?)->Void)
}