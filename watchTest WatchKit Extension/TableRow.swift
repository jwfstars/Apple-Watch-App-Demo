//
//  tableRow.swift
//  watchTest
//
//  Created by jwfstars on 14/12/9.
//  Copyright (c) 2014年 jwfstars. All rights reserved.
//

import UIKit
import Foundation
import WatchKit


class TableRow: NSObject {

    @IBOutlet weak var priceLabel: WKInterfaceLabel!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    
    
    func setItem(stock : Stock) {
        priceLabel .setText("\(stock.price)")
        nameLabel.setText(stock.stockName)

        if stock.isUP == true {
            priceLabel.setTextColor(UIColor.redColor())
        }else {
            priceLabel.setTextColor(UIColor.greenColor())
        }
        
        
    }
}


