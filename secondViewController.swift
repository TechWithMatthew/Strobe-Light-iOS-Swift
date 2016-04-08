//
//  secondViewController.swift
//  Strobe Light
//
//  Created by Matthew on 3/14/16.
//  Copyright © 2016 Matthew Purcell. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class secondViewController: UIViewController {
    
    
    @IBOutlet weak var btnOn: UIButton!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    //Variables
    var lightTimer = NSTimer()
    var offTimer = NSTimer()
    var lightIsOn = false
    var onTime:Double = 0.01
    var offTime:Double = 0.0
    var secondOffTime:Double = 0.0
    var shouldDouble:Bool = false
    var firstOfDouble = false
    
    // Needed to make flash stuff work
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
   
    
    @IBAction func btnOnAction(sender: AnyObject) {
        
        
        if lightIsOn == true {
            
            lightOff()
            lightIsOn = false
            btnOn.setTitle("OFF", forState: UIControlState.Normal)
        }
        else {
            lightIsOn = true
            btnOn.setTitle("ON", forState: UIControlState.Normal)
            segControlAction(self)
            
        }
    }
    
    @IBAction func segControlAction(sender: AnyObject) {
  
        if segControl.selectedSegmentIndex == 0 {
            print("\(segControl.selectedSegmentIndex) Slow")
            // on time 0.01
            // off time 1.6
            onTime = 0.01
            offTime = 1.6
            shouldDouble = false
            lightIsOn = true
            checkBtnOn()
            lightOn()
            
        }
        else if segControl.selectedSegmentIndex == 1 {
            print("\(segControl.selectedSegmentIndex) Normal")
            // on time 0.01
            // off time 1.2
            offTime = 1.2
            shouldDouble = false
            lightIsOn = true
            checkBtnOn()
            lightOn()
            
        }
        else if segControl.selectedSegmentIndex == 2 {
            print("\(segControl.selectedSegmentIndex) Fast")
            // off time 1.0
            offTime = 1.0
            shouldDouble = false
            lightIsOn = true
            checkBtnOn()
            lightOn()
            
        }
        else if segControl.selectedSegmentIndex == 3 {
            print("\(segControl.selectedSegmentIndex) Faster")
            // off time 0.7
            offTime = 0.7
            shouldDouble = false
            lightIsOn = true
            checkBtnOn()
            lightOn()
        }
        else if segControl.selectedSegmentIndex == 4 {
            print("\(segControl.selectedSegmentIndex) Faster")
            // On time = 0.01
            // Off time = 1.0
            // Second Off Time = 0.3
            offTime = 1.4
            secondOffTime = 0.3
            shouldDouble = true
            lightIsOn = true
            checkBtnOn()
            lightOn()
            
        }
        
        
    }
    
    func checkBtnOn() {
        
        if lightIsOn == false {
            btnOn.setTitle("OFF", forState: UIControlState.Normal)
        }
        else {
            btnOn.setTitle("ON", forState: UIControlState.Normal)
        }
    }
    func lightOn() {
        
        
        if shouldDouble == true {
            
            //turns light on the first time
            if firstOfDouble == false {
             
                firstOfDouble = true
                if (device.hasTorch) {
                    do {
                        try device.lockForConfiguration()
                    
                        try device.setTorchModeOnWithLevel(1.0)
                    
                        device.unlockForConfiguration()
                    
                    } catch {
                        print(error)
                    }
                }
                offTimer.invalidate()
                lightTimer = NSTimer.scheduledTimerWithTimeInterval(onTime, target: self, selector: #selector(secondViewController.lightOffTimed), userInfo: nil, repeats: true)
            }
                
            //turns light on for the second time
            else {
                    firstOfDouble = false
                    if (device.hasTorch) {
                        do {
                            try device.lockForConfiguration()
                            
                            try device.setTorchModeOnWithLevel(1.0)
                            
                            device.unlockForConfiguration()
                            
                        } catch {
                            print(error)
                        }
                    }
                    offTimer.invalidate()
                    lightTimer = NSTimer.scheduledTimerWithTimeInterval(onTime, target: self, selector: #selector(secondViewController.doubleOffTimed), userInfo: nil, repeats: true)
                }
            
        }
        // non double light
        else if shouldDouble == false {
            
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
        
                try device.setTorchModeOnWithLevel(1.0)
               
                device.unlockForConfiguration()
                
            } catch {
                print(error)
            }
        }
        
        offTimer.invalidate()
        lightTimer = NSTimer.scheduledTimerWithTimeInterval(onTime, target: self, selector: #selector(secondViewController.lightOffTimed), userInfo: nil, repeats: true)
        
    
        }
    }
    
    func lightOffTimed() {
        
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                
                device.torchMode = AVCaptureTorchMode.Off
                device.unlockForConfiguration()
                
            } catch {
                print(error)
            }
        }
        lightTimer.invalidate()
        offTimer = NSTimer.scheduledTimerWithTimeInterval(offTime, target: self, selector: #selector(secondViewController.lightOn), userInfo: nil, repeats: true)
    }
    
    func doubleOffTimed() {
        
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                
                device.torchMode = AVCaptureTorchMode.Off
                device.unlockForConfiguration()
                
            } catch {
                print(error)
            }
        }
        lightTimer.invalidate()
        offTimer = NSTimer.scheduledTimerWithTimeInterval(secondOffTime, target: self, selector: #selector(secondViewController.lightOn), userInfo: nil, repeats: true)
    }
    
    //Turns light off no matter what the setting is
    func lightOff() {
        
        print("lightOff() run")
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                
                device.torchMode = AVCaptureTorchMode.Off
                device.unlockForConfiguration()
                
            } catch {
                print(error)
            }
        }
        lightIsOn = false
        offTimer.invalidate()
        lightTimer.invalidate()
        
    }
    
    @IBAction func btnStrobeLight(sender: AnyObject) {
        lightOff()
    }
    
    
    //Makes status bar white
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}