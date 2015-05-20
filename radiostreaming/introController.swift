//
//  introController.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/17/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit

class IntroController: UIViewController{

    @IBOutlet weak var infoConnect: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var pleaseWait: UILabel!
    
    var dataProvider: DataProviderContract
    
    required init(coder aDecoder: NSCoder)
    {
        self.dataProvider = OAuthService()
        super.init(coder: aDecoder)
    }
    
    @IBAction func connectPressed(sender: UIButton) {
        self.run()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //Bootstraping
        // Set activity indicator hidden when stopped
        self.activityIndicator.hidesWhenStopped = true;
        self.run()
        
    }
    
    func run(){
        //hide reconnection option
        self.hideReconnectionOption()
        // Start activity indicator
        self.showActivityIndicator()
        // Check whether internet connection is available
        self.checkConnectivity { () -> Void in
            // Connection available, Setup provider
            self.setupDataProvider({ (result) -> Void in
                if let res = result{
                    //get Radio Profile Data
                    self.radioProfileData(4)
                }
            })
        }
    }
    func hideReconnectionOption(){
        //Hide connection button and label
        self.infoConnect.hidden = true
        self.connectButton.hidden = true
        self.pleaseWait.hidden = false
    }
    
    func showActivityIndicator(){
        activityIndicator.startAnimating()
        self.loadingLabel.hidden = false
    }
    
    func hideActivityIndicator(){
        activityIndicator.stopAnimating()
        self.loadingLabel.hidden = true
    }
    
    func showReconnectionOption(){
        self.connectButton.hidden = false
        self.infoConnect.hidden = false
        self.pleaseWait.hidden = true
    }
    
    func setupDataProvider(success: (result: NSDictionary?)->Void){
        self.dataProvider.run { (response) -> Void in
            //Access Token Received
            if (response["access_token"] != nil){
               success(result: response)
            }else{
                success(result: nil)
            }
        }
    }
    
    func checkConnectivity(success: ()->Void){
        self.dataProvider.checkConnectivity { (response) -> Void in
            print(response)
            if (response == nil){
                let alert = UIAlertController(title: "Alert", message: "No Internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.presentViewController(alert, animated: true, completion: nil)
                    self.hideActivityIndicator()
                    self.showReconnectionOption()
                })
            }else{
                success()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toPlayer"){
            let playerController = segue.destinationViewController as! ViewController
            let radioData: NSDictionary = NSJSONSerialization.JSONObjectWithData(sender as! NSData, options: nil, error: nil) as! NSDictionary
            playerController.radioData = radioData

        }
    }
    
    func radioProfileData(id: Int){
        self.dataProvider.get("api/radio/\(id)", callback: { (result, error) -> Void in
            if let res = result{
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.performSegueWithIdentifier("toPlayer", sender: result)
                })
            }
        })
    }

}