//
//  InterfaceController.swift
//  watchLight Extension
//
//  Created by Matthew on 3/20/16.
//  Copyright © 2016 Matthew Purcell. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    //
    // Simple flashlight for the watch
    //
    
    @IBOutlet var btnLightOn: WKInterfaceButton!
    
    var lightOn = false
    
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
    @IBAction func btnLightOnAction() {
  
        if lightOn == false {
            btnLightOn.setBackgroundColor(UIColor.whiteColor())
            lightOn = true
            WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Click)
        }
        else {
            btnLightOn.setBackgroundColor(UIColor.blackColor())
            lightOn = false
        }
    }
    

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        btnLightOn.setBackgroundColor(UIColor.blackColor())
        super.didDeactivate()
    }

}
