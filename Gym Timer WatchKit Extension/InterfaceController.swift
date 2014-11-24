//
//  InterfaceController.swift
//  Gym Timer WatchKit Extension
//
//  Created by Waleed Abdulla on 11/23/14.
//  Copyright (c) 2014 Waleed. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    var gStatus:String = ""
    var gActiveSeconds = 5.0 + 1
    var gRestSeconds = 5.0

    @IBOutlet weak var btnStart: WKInterfaceButton!
    @IBOutlet weak var timer: WKInterfaceTimer!
    @IBOutlet weak var group: WKInterfaceGroup!
    @IBOutlet weak var groupActive: WKInterfaceGroup!
    @IBOutlet weak var groupRest: WKInterfaceGroup!
    @IBOutlet weak var activeSlider: WKInterfaceSlider!
    @IBOutlet weak var restSlider: WKInterfaceSlider!
    
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        
        // Configure interface objects here.
        NSLog("%@ init", self)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

    @IBAction func btnStart_click() {
        switchStatus()
    }
    
    func switchStatus(){
        
        if (gStatus == ""){
            gStatus = "active"
            
            btnStart.setHidden(true)
            groupActive.setHidden(true)
            groupRest.setHidden(true)
            timer.setHidden(false)
            
            // Set image
            group.setBackgroundImageNamed("workout")

            // Start timer.
            timer.setDate(NSDate(timeIntervalSinceNow:NSTimeInterval(0)))
            timer.start()
            var nstimer = NSTimer.scheduledTimerWithTimeInterval(
                gActiveSeconds,
                target: self,
                selector: Selector("switchStatus"),
                userInfo: nil,
                repeats: false)
        }
        else if (gStatus == "active") {
            gStatus = "rest"
            
            // Set image
            group.setBackgroundImageNamed("rest")

            // Start timer.
            timer.setDate(NSDate(timeIntervalSinceNow:NSTimeInterval(0)))
            timer.start()
            var nstimer = NSTimer.scheduledTimerWithTimeInterval(
                gRestSeconds,
                target: self,
                selector: Selector("switchStatus"),
                userInfo: nil,
                repeats: false)
        }
        else {
            gStatus = ""
            btnStart.setHidden(false)
            timer.stop()
            timer.setHidden(true)
        }

    }
    
    @IBAction func activeSlider_value(value: NSObject) {
        let fValue = value as Float
        gActiveSeconds = Double(fValue) * 6.0/10.0
    }
    
    @IBAction func restSlider_value(value: NSObject) {
        let fValue = value as Float
        gRestSeconds = Double(fValue) * 6.0/10.0
    }
}
