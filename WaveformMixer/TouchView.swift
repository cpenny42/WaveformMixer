//
//  TouchView.swift
//  WaveformMixer
//
//  Created by Chris Penny on 6/3/15.
//  Copyright (c) 2015 Tufts University. All rights reserved.
//

import Foundation

class TouchView: UIView {
    
    var voicesInput = "voices" // Receiver in Pd to send messages to
    
    var nextVoice: Int {
        get {
            var availableVoices = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
            
            for (touch, voice) in allTouches {
                
                availableVoices[voice] = 0
            }
            
            for i in 0...9 {
                if availableVoices[i] == 1 {
                    return i
                }
            }
            
            return 0
        }
    }
    
    var allTouches = [UITouch: Int]() // Dictionary associates each touch with a voice
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for currentTouchObject in touches {
            let currentTouch = currentTouchObject as! UITouch
            
                let currentVoice = nextVoice
                allTouches[currentTouch] = currentVoice
                
                let volume = 1 - (currentTouch.locationInView(self).y / self.frame.height)
                let pitch = (currentTouch.locationInView(self).x / self.frame.width) * 80 + 20
                
                PdBase.sendList([currentVoice, "pitch", pitch], toReceiver: voicesInput)
                PdBase.sendList([currentVoice, "volume", volume], toReceiver: voicesInput)
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for currentTouchObject in touches {
            let currentTouch = currentTouchObject as! UITouch
            let currentVoice = allTouches[currentTouch]!
            
            let volume = 1 - (currentTouch.locationInView(self).y / self.frame.height)
            let pitch = (currentTouch.locationInView(self).x / self.frame.width) * 80 + 20
            
            PdBase.sendList([currentVoice, "pitch", pitch], toReceiver: voicesInput)
            PdBase.sendList([currentVoice, "volume", volume], toReceiver: voicesInput)
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for currentTouchObject in touches {
            let currentTouch = currentTouchObject as! UITouch
            let currentVoice = allTouches[currentTouch]!
            
            PdBase.sendList([currentVoice, "volume", 0], toReceiver: voicesInput)
            allTouches.removeValueForKey(currentTouch)
        }
        
    }
    
}
