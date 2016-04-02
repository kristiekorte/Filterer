//
//  InterfaceController.swift
//  FilterWatch Extension
//
//  Created by Kristie Korte on 4/2/16.
//  Copyright © 2016 UofT. All rights reserved.
//

import WatchKit
import Foundation
import UIKit


class InterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        //animateWithDuration(0.4, animations: <#T##() -> Void#>)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
       
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
   
    @IBAction func onNewPhoto() {
        
    }

        
    
    @IBAction func onRedFilter() {
        NSLog("Touched Red Button")
        
    }
    @IBAction func onBlueFilter() {
        NSLog("Touched Blue Button")
    }
    @IBAction func onGreenFilter() {
        NSLog("Touched Blue Button")
    }
    
    @IBAction func onYellowFilter() {
        NSLog("Touched Yellow Button")

    }
    @IBAction func onPurpleFilter() {
        NSLog("Touched Purple Button")
    }

    @IBAction func onEditButton() {
        NSLog("Touched Edit Button")

    }
}
