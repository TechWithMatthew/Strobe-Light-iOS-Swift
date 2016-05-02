//
//  AboutViewController.swift
//  Strobe Light
//
//  Created by Matthew on 4/20/16.
//  Copyright © 2016 Matthew Purcell. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
   
    var numberFormatter = NSNumberFormatter()
    
    
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblCount: UILabel!

    @IBAction func btnAboutAction(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnGitHubURL(sender: AnyObject) {
        let GitHubURL = NSURL(string: "https://github.com/TechWithMatthew/Strobe-Light-iOS-Swift")!
        UIApplication.sharedApplication().openURL(GitHubURL)
    }
    
    @IBAction func btnNoobProgrammingURL(sender: AnyObject) {
        let noobProgrammingURL = NSURL(string: "https://www.youtube.com/playlist?list=PL5oAGpeRFTbosS2edK0yja_jb27xXbEW4")!
        UIApplication.sharedApplication().openURL(noobProgrammingURL)
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
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        lblCount.text = "Total Light Flashes: \(numberFormatter.stringFromNumber(getCount())!)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

