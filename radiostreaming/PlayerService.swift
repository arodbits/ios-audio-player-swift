//
//  PlayerService.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 4/27/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlayerService{
    
    var streamingURL:NSURL
    var audioPlayer:AVPlayer
    
    init(){
        self.streamingURL = NSURL(string: "")!
        let audioStreamingItem = AVPlayerItem(URL: self.streamingURL)
        self.audioPlayer = AVPlayer(playerItem: audioStreamingItem)
    }
    
    
    func play(){
        self.audioPlayer.rate = 1.0
        self.play()
    }
    
}