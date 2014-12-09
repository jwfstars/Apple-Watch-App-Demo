//
//  TableRow.swift
//  watchTest
//
//  Created by jwfstars on 14/12/4.
//  Copyright (c) 2014年 jwfstars. All rights reserved.
//

import UIKit
import WatchKit

class TableRow: NSObject {
   
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var priceLabel: WKInterfaceLabel!
    @IBOutlet weak var image: WKInterfaceImage!
    
    
    func setItem(stock : Stock) {
        
        nameLabel.setText(stock.stockName)
        priceLabel.setText("\(stock.price)")

        //image位置不同方法不同
        if stock.isUP == true {
            image.setImageNamed("arrow_red")
            priceLabel.setTextColor(UIColor.redColor())
        }else {
            image.setImageNamed("arrow_green")
            priceLabel.setTextColor(UIColor.greenColor())
        }
    }
}
