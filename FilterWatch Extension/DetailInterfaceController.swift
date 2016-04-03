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
                nameLabel.setText("You selected the row for \(selectedName)")
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

}
