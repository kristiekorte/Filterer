//
//  DetailInterfaceController.swift
//  Filterer
//
//  Created by Kristie Korte on 4/2/16.
//  Copyright © 2016 UofT. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {
    
    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var image : WKInterfaceImage!
    


    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        if let contextDictionary = context as? Dictionary<String, String> {
            
            if let selectedName =  contextDictionary["selectedName"] {
                //nameLabel.setText("\(selectedName)")
                nameLabel.setText("Choose a Color")

                if let picture = UIImage(named: selectedName) {
                    image.setImage(picture)
                }
            }
            
            
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func dored() {
    image.setTintColor(UIColor.redColor())
        
    }

    @IBAction func doOrange() {
        image.setTintColor(UIColor.orangeColor())

    }
    
    @IBAction func doYellow() {
        image.setTintColor(UIColor.yellowColor())

    }
    @IBAction func doGreen() {
        image.setTintColor(UIColor.greenColor())

    }
   
    @IBAction func doBlue() {
        image.setTintColor(UIColor.blueColor())

    }
    
    @IBAction func doPurple() {
        image.setTintColor(UIColor.purpleColor())

    }
}
