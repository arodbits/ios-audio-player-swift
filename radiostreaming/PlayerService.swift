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
    var app: AppDelegate
    var audioStreamingItem: AVPlayerItem
    init(){
        self.streamingURL = NSURL(string: "http://s8.voscast.com:9476")!
        self.audioStreamingItem = AVPlayerItem(URL: self.streamingURL)
        self.audioPlayer = AVPlayer(playerItem: self.audioStreamingItem)
        self.app = UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    func play()->Bool{
        if self.app.checkConnectivity(){
            self.audioPlayer.rate = 1.0
            self.audioPlayer.play()
            return true
        }
        return false
    }
    
    func stop()->Bool{
        if self.app.checkConnectivity(){
            self.audioPlayer.pause()
            return true
        }
        return false
    }
    
    func volume(value: Float){
        self.audioPlayer.volume = value
        println(value)
    }
    
    deinit{
        self.audioPlayer.finalize()
    }
    
}