//
//  ViewController.swift
//  watchTest
//
//  Created by jwfstars on 14/12/3.
//  Copyright (c) 2014年 jwfstars. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    let dataManager = DataManager()
    var stockItemArray = NSArray()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataManager.requestPrice { (stockItems, error) -> () in
            self.stockItemArray = stockItems!
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stockItemArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as StockCell
        cell.configureCell(self.stockItemArray[indexPath.row] as Stock)
    
        return cell
    }
}

class StockCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureCell(stock : Stock) {
        
        nameLabel.text = stock.stockName
        priceLabel.text = "\(stock.price)"
        
        if stock.statusUP == true {
            priceLabel.textColor = UIColor.redColor()
        }else {
            priceLabel.textColor = UIColor.greenColor()
        }
    }

}