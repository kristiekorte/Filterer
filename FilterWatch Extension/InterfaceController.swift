//
//  InterfaceController.swift
//  FilterWatch Extension
//
//  Created by Kristie Korte on 4/2/16.
//  Copyright © 2016 UofT. All rights reserved.
//

import WatchKit
import Foundation



class InterfaceController: WKInterfaceController {
    
    @IBOutlet var watchTable: WKInterfaceTable!
    var dataArray = [String]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        setupData()
        updateTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
       
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func setupData() {
        dataArray.append("Bob")
        dataArray.append("Felix")
        dataArray.append("Jim")
        dataArray.append("Fred")
    }
    
    func updateTable() {
        
        // Create array to hold the row types
        var rowTypes = [String]()
        
        // Add header row as the row 0
        rowTypes.append("TopRow")
        
        // Add a contact row for each object in the dataArray
        for _ in dataArray {
            rowTypes.append("ImageRow")
        }
        
        // Configure the table to display the rows as defined in the rowsArray
        watchTable.setRowTypes(rowTypes)
        
        // Retrieve each contact row and set the contents from the dataArray
        // Start at row 1, because row 0 is the header row
        for index in 0..<dataArray.count {
            
            let imageRow = watchTable.rowControllerAtIndex(index+1) as! ImageRowController
            
            let rowContent = dataArray[index]
            
            
            if let image = UIImage(named: rowContent) {
                imageRow.rowImage.setImage(image)
            }
            
        }
        
        let imageCount = dataArray.count
        
        
    }
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        table.setRowTypes(["HeaderCell", "DataCell", "DataCell", "FooterCell"])
        
        for index in 0..<dataArray.count {
            let imageRow = watchTable.rowControllerAtIndex(index+1) as! ImageRowController
        }
        
        //let selectedRow = watchTable.rowControllerAtIndex(rowIndex) as! ImageRowController
        
        
        let contextDictionary = ["selectedName" : self.dataArray[rowIndex - 1]]
        
        self.pushControllerWithName("DetailInterface", context: contextDictionary)
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        if segueIdentifier == "PushDetailScreenSegue" {
            return ["selectedName" : dataArray[rowIndex - 1]]
        }
        
        return nil
        
    }

    
    }
