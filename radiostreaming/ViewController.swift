//
//  ViewController.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 4/26/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let player = PlayerService()
    let defaults = NSUserDefaults.standardUserDefaults()
    // radioData data is aquired from the introController View before this viewController is executed!
    var radioData: NSDictionary = NSDictionary()

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func eventsPressed(sender: UIButton) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.performSegueWithIdentifier("playerTOEvents", sender: AnyObject?())
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let id = segue.identifier
        if id == "playerTOEvents"{
            let eventsController = segue.destinationViewController as? EventsController
            
            eventsController?.backgroundImage = self.backgroundImage.image!
            
        }
    }
    
    @IBAction func backFromEventsController(segue:UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        //Bootstraping
        self.stopButton.hidden = true
        self.displayRadioData()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hide status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func displayRadioData(){
        if let name = self.radioData["name"] as? String{
            self.name.text = name
        }
        if let slogan = self.radioData["slogan"] as? String{
            self.slogan.text = slogan
        }
        if let image64base = self.radioData["logo"] as? String{
            let imageData = NSData(base64EncodedString: (image64base), options: nil)
            self.logoImage.image = UIImage(data: imageData!)
            self.backgroundImage.image = UIImage(data: imageData!)
        }
    }
    
    //Streaming actions
    func toggleButton(me: UIButton, next: UIButton){
        me.hidden = !me.hidden
        next.hidden = !next.hidden
    }

    @IBAction func playPressed(sender: UIButton) {
        if self.player.play(){
            self.toggleButton(sender, next: self.stopButton)
        }
    }

    @IBAction func stopPressed(sender: UIButton) {
        self.player.stop()
        self.toggleButton(sender, next: self.playButton)
    }
    
    // Volume action
    
    @IBAction func volumenSlider(sender: UISlider) {
       self.player.volume(sender.value)
        
    }
    
    //Social actions
    @IBAction func twitterPressed(sender: UIButton) {
        
        if let twitterUrl = self.radioData["twitter"] as? String {
            UIApplication.sharedApplication().openURL(NSURL(string: twitterUrl)!)
        }
        
    }
    @IBAction func instagramPressed(sender: UIButton) {
        if let instagramUrl = self.radioData["instagram"] as? String {
            UIApplication.sharedApplication().openURL(NSURL(string: instagramUrl)!)
        }
    }
    @IBAction func facebookPressed(sender: UIButton) {
        if let facebookUrl = self.radioData["facebook"] as? String {
            print(facebookUrl)
            UIApplication.sharedApplication().openURL(NSURL(string: facebookUrl)!)
        }
    }
    @IBAction func youtubePressed(sender: UIButton) {
        if let youtubeUrl = self.radioData["youtube"] as? String {
            UIApplication.sharedApplication().openURL(NSURL(string: youtubeUrl)!)
        }
    }
}

