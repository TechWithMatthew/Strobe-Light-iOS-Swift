//
//  ViewController.swift
//  Strobe Light
//
//  Created by Matthew on 3/12/16.
//  Copyright © 2016 Matthew Purcell. All rights reserved.
//
//
// Please Note: Whenever the flash light is turned on fromt the simulator
// it just crashes. For this reason all testing needs to be done on device.
// Also trying to switch between the view controllers will crash the simulator
// this also works fine on device.


import UIKit
import AVFoundation

let count = NSUserDefaults.standardUserDefaults()

class ViewController: UIViewController {
   
    //The Master File
    
    //Outlets
    @IBOutlet weak var btnStrobeLightOutlet: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblSpeed: UILabel!
    
    
    //Variables
    var strobeOn = false
    var buttonOn = false
    var lightShouldAlwaysBeOn = false
    var lightShouldAlwaysBeOff = true
    var timer = NSTimer()
    var dblTimerSpeed:Double = 0.0648415
    var fltStrobeSpeed:Float = 0.0
    var intStrobeSpeed:Int = 0
    var sliderRange:Float = 0.897
    
    
    
    //This is needed to make all the flash light stuff work
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let avDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    //All the Magic happens below this
    @IBAction func btnStrobeLight(sender: AnyObject) {
        
        if buttonOn == true {
            
            timer.invalidate()
            btnStrobeLightOutlet.setTitle("OFF", forState: UIControlState.Normal)
            buttonOn = false
            lightShouldAlwaysBeOff = true
            lightShouldBeOff()
            
        }
            
        else {
            
            buttonOn = true
            lightShouldAlwaysBeOn = false
            strobeLight()
            btnStrobeLightOutlet.setTitle("ON", forState: UIControlState.Normal)
            
            theSlider()
           
        }
    }
    

    @IBAction func sliderAction(sender: AnyObject) {
    
        theSlider()
    }
    
    //This theSlider() function was created so that I could call the function in the btnStrobeLight function
    
    func theSlider() {
        // caping the lowest speed at .041000
        // highest speed before ∞ will be .92000
        // the defualt speed is 0.0648415
        
        print(slider.value)
        
        //set value of the slider to dblTimerSpeed and convert the slider which is a float to double. The timer only accepts double.
        dblTimerSpeed = Double(slider.value)
        print("dblTimerSpeed \(dblTimerSpeed)")
        
        if dblTimerSpeed >= 0.92 {
            
            timer.invalidate()
            lightShouldAlwaysBeOn = true
            lightAlwaysOn()
            
        }
            
        else {
            lightShouldAlwaysBeOn = false
            
            timer.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(dblTimerSpeed, target: self, selector: #selector(ViewController.strobeLight), userInfo: nil, repeats: true)
            
        }
        
        lightShouldBeOff()
    }
    
    func strobeLight() {

        //Turns the light on and off
       
        if buttonOn == true {
        
        if (device.hasTorch){
            do {
                try device.lockForConfiguration()
                
                if strobeOn == true {
                    device.torchMode = AVCaptureTorchMode.Off
                    strobeOn = false
                    
                }
                    
                else {
                    
                    try device.setTorchModeOnWithLevel(1.0)
                    strobeOn =  true
                    setCount(getCount() + 1)
                    print(getCount())
                    
                    if buttonOn == false {
                        device.torchMode = AVCaptureTorchMode.Off
                    }
                    
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        
        }

    }
    
    
    func lightAlwaysOn() {
        
        lightShouldAlwaysBeOff = false
        buttonOn = true
        btnStrobeLightOutlet.setTitle("ON", forState: UIControlState.Normal)
        if (device.hasTorch){
            do {
                try device.lockForConfiguration()
                
                if lightShouldAlwaysBeOn == true {
                    device.torchMode = AVCaptureTorchMode.On
                    
                    }
                else {
                    device.torchMode = AVCaptureTorchMode.Off
                }
     
                device.unlockForConfiguration()
            } catch {
             print("error")
            }
        }
        

    }
    
    func lightShouldBeOff() {
       
        if (device.hasTorch){
            do {
                try device.lockForConfiguration()
                
                if lightShouldAlwaysBeOff == true {
                    device.torchMode = AVCaptureTorchMode.Off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("error")
            }
        }

    }
    
    //Calculates the speed of the strobe light and outputs it to the label
    @IBAction func sliderSpeedAction(sender: AnyObject) {
      
        sliderSpeedCalc()
    
    }
    //This function is needed so that it can be called in the viewDidLoad as well as in the function above
    func sliderSpeedCalc() {
        //
        //slider range is .897
        //slider range 909
        
        if slider.value >= 0.92 {
            lblSpeed.text = "Always On"
        }
        else if slider.value <= 0.041 {
            lblSpeed.text = "Really Fast!"
        }
        else {
        fltStrobeSpeed = slider.value * 100
        print("Strobe speed \(fltStrobeSpeed)")
        intStrobeSpeed = Int(fltStrobeSpeed)
        
        lblSpeed.text = "Strobe Speed: \(intStrobeSpeed)"
        }
    }
    
    
    @IBAction func btnFastFlash(sender: AnyObject) {
   
        timer.invalidate()
        btnStrobeLightOutlet.setTitle("OFF", forState: UIControlState.Normal)
        buttonOn = false
        lightShouldAlwaysBeOff = true
        lightShouldBeOff()
        
    }
    

    @IBAction func btnAbout(sender: AnyObject) {
       
        timer.invalidate()
        btnStrobeLightOutlet.setTitle("OFF", forState: UIControlState.Normal)
        buttonOn = false
        lightShouldAlwaysBeOff = true
        lightShouldBeOff()
    }

    func setCount(theCount: Int) {
        count.setInteger(theCount, forKey: "Flash Count")
    }
    
    func getCount() -> Int {
        return count.integerForKey("Flash Count")
    }

    
    //Makes status bar white
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Disables auto lock
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        //Calculates the strobe speed
        sliderSpeedCalc()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

