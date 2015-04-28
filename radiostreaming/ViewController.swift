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
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.hidden = true
        
        
        // Do any additional setup after loading the view, typically from a nib.
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
        self.toggleButton(sender, next: self.playButton)    }
}

