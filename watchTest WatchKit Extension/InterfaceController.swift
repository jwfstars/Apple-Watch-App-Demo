//
//  InterfaceController.swift
//  watchTest WatchKit Extension
//
//  Created by jwfstars on 14/12/3.
//  Copyright (c) 2014年 jwfstars. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    let dataManager = DataManager()
    var stockItemArray = NSMutableArray()
    

    @IBOutlet weak var table: WKInterfaceTable!

    @IBAction func refresh() {
        loadTableData()
    }
    
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        
        loadTableData()
        
        // Configure interface objects here.
        NSLog("%@ init", self)
    }
    
    func loadTableData() {

        self.stockItemArray.removeAllObjects()
        
        dataManager.requestPrice { (stockItems, error) -> () in
            self.stockItemArray.addObjectsFromArray(stockItems!)
            let count = self.stockItemArray.count
            self.table.setNumberOfRows(self.stockItemArray.count, withRowType: "row")
            
            for (index,stock) in enumerate(self.stockItemArray) {
                let row = self.table.rowControllerAtIndex(index) as TableRow
                let stock = stock as Stock
                
                row.nameLabel.setText(stock.stockName)
                row.priceLabel.setText("\(stock.price)")
                //image位置不同方法不同
                
                if stock.statusUP == true {
                    row.image.setImageNamed("arrow_red")
                    row.priceLabel.setTextColor(UIColor.redColor())
                }else {
                    row.image.setImageNamed("arrow_green")
                    row.priceLabel.setTextColor(UIColor.greenColor())
                }
            }
        }
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
