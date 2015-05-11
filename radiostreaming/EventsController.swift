//
//  EventsController.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/8/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit

class EventsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let events = ["event 1", "event 2", "Event 3"]

    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let oauth = OAuthService()
        oauth.getAccessToken { (result) -> Void in
            let jsonResult = NSJSONSerialization.JSONObjectWithData(result as! NSData, options: nil, error: nil) as! NSDictionary
            let token = jsonResult["access_token"]
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.events.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.myTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventsCells;
        var event = self.events[indexPath.row]
        cell.backgroundColor = UIColor.purpleColor();
        cell.dayWeek.text = event
        return cell
    }

}
