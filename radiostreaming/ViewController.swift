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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playPressed(sender: UIButton) {
        self.player.play()
    }

    @IBAction func stopPressed(sender: UIButton) {
        self.player.stop()
    }
}
