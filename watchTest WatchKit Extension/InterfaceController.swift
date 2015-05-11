//
//  InterfaceController.swift
//  watchTest WatchKit Extension
//
//  Created by jwfstars on 14/12/9.
//  Copyright (c) 2014年 jwfstars. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    
    let dataManager = DataManager()
    var stockArray = NSMutableArray()
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    @IBAction func refresh() {
        loadStockData()
    }
    
    func loadStockData() {
        
        stockArray.removeAllObjects()
        
        dataManager.requestPrice { (stockItems, error) -> () in
            
            self.stockArray .addObjectsFromArray(stockItems! as [AnyObject])
            
            self.table.setNumberOfRows(self.stockArray.count, withRowType: "row")
            
            for (index, stockItem) in enumerate(self.stockArray) {
                println(index)
                
                let row = self.table .rowControllerAtIndex(index) as! TableRow
                
                row.setItem(stockItem as! Stock)
            }
            
        }
    }
    
    override init() {
        super.init()
        
        loadStockData()
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

}
