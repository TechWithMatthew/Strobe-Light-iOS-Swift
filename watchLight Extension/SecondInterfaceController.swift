//
//  SecondInterfaceController.swift
//  Strobe Light
//
//  Created by Matthew on 4/19/16.
//  Copyright © 2016 Matthew Purcell. All rights reserved.
//

import Foundation
import WatchKit

class SecondInterfaceController: WKInterfaceController {
    
    
    @IBOutlet var btnStrobe: WKInterfaceButton!
    
    var lightOn = false
    var strobeOn = false
    var timer = NSTimer()
    var dblTimerSpeed = 0.5

    
    
    @IBAction func btnStrobeAction() {
        
        if strobeOn == false {
            strobeOn = true
        }
        else {
            strobeOn = false
            
        }
        
        
        if strobeOn == true {
            lightOn = false
            timer = NSTimer.scheduledTimerWithTimeInterval(dblTimerSpeed, target: self, selector: #selector(SecondInterfaceController.strobeLight), userInfo: nil, repeats: true)

        }
        else {
            turnLightOff()
            
        }
    }
    
    
    
    func turnLightOff() {
        btnStrobe.setTitle("Tap for strobe")
        timer.invalidate()
        btnStrobe.setBackgroundColor(UIColor.blackColor())
        
    }
    
    func strobeLight() {

        if lightOn == false {
            btnStrobe.setBackgroundColor(UIColor.whiteColor())
            WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Click)
            lightOn = true
        }
        else {
            btnStrobe.setBackgroundColor(UIColor.blackColor())
            btnStrobe.setTitle("")
            lightOn = false
        }
    }
    
    @IBAction func btnFast() {
        timer.invalidate()
        dblTimerSpeed = 0.15
        strobeOn = true
        timer = NSTimer.scheduledTimerWithTimeInterval(dblTimerSpeed, target: self, selector: #selector(SecondInterfaceController.strobeLight), userInfo: nil, repeats: true)

    }

    @IBAction func btnNormal() {
        timer.invalidate()
        dblTimerSpeed = 0.5
        strobeOn = true
        timer = NSTimer.scheduledTimerWithTimeInterval(dblTimerSpeed, target: self, selector: #selector(SecondInterfaceController.strobeLight), userInfo: nil, repeats: true)
    }
    @IBAction func btnSlow() {
        timer.invalidate()
        dblTimerSpeed = 0.8
        strobeOn = true
        timer = NSTimer.scheduledTimerWithTimeInterval(dblTimerSpeed, target: self, selector: #selector(SecondInterfaceController.strobeLight), userInfo: nil, repeats: true)
    }
    
    
    func playHaptic(Click_ type: WKHapticType) {
      
        enum WKHapticType : Int {
            case Notification
            case DirectionUp
            case DirectionDown
            case Success
            case Failure
            case Retry
            case Start
            case Stop
            case Click
        }
    }
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        lightOn = false
        strobeOn = false
        btnStrobe.setBackgroundColor(UIColor.blackColor())
        btnStrobe.setTitle("Tap for strobe")
        // This method is called when watch view controller is about to be visible to user
        
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        timer.invalidate()
        super.didDeactivate()
    }
    
}
