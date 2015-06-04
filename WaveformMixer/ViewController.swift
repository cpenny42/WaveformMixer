//
//  ViewController.swift
//  WaveformMixer
//
//  Created by Chris Penny on 6/3/15.
//  Copyright (c) 2015 Tufts University. All rights reserved.
//

import Foundation

class ViewController: UIViewController {
    
    var file: UnsafeMutablePointer<Void>
    
    required init(coder aDecoder: NSCoder) {
        
        file = PdBase.openFile("main.pd", path: NSBundle.mainBundle().resourcePath)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        PdBase.sendFloat(0.8, toReceiver: "master_volume")
    }
        
    @IBAction func sineMix(sender: UISlider) {
        PdBase.sendFloat(sender.value, toReceiver: "mix.sine")
    }
    
    @IBAction func triangleMix(sender: UISlider) {
        PdBase.sendFloat(sender.value, toReceiver: "mix.triangle")
    }
    
    @IBAction func sawtoothMix(sender: UISlider) {
        PdBase.sendFloat(sender.value, toReceiver: "mix.sawtooth")
    }
    
    @IBAction func squareMix(sender: UISlider) {
        PdBase.sendFloat(sender.value, toReceiver: "mix.square")
    }
    
}