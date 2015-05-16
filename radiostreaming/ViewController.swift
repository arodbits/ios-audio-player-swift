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
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func eventsPressed(sender: UIButton) {
        performSegueWithIdentifier("playerTOEvents", sender: AnyObject?())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.hidden = true
        
        let oauth = OAuthService()
        oauth.run()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleButton(me: UIButton, next: UIButton){
        me.hidden = !me.hidden
        next.hidden = !next.hidden
    }

    @IBAction func playPressed(sender: UIButton) {
        self.player.play()
        self.toggleButton(sender, next: self.stopButton)
    }

    @IBAction func stopPressed(sender: UIButton) {
        self.player.stop()
        self.toggleButton(sender, next: self.playButton)
    }
    
    @IBAction func volumenSlider(sender: UISlider) {
       self.player.volume(sender.value)
        
    }
    @IBAction func twitterPressed(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/momentodedios")!)
    }
    @IBAction func instagramPressed(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://instagram.com/anthonymdd/")!)
    }
    @IBAction func facebookPressed(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/momentodedios")!)
    }
    @IBAction func youtubePressed(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.youtube.com/user/MomentodeDios")!)
    }
}

