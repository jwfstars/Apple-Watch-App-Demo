//
//  DataManager.swift
//  watchTest
//
//  Created by jwfstars on 14/12/4.
//  Copyright (c) 2014年 jwfstars. All rights reserved.
//

import UIKit
import Foundation

public typealias PriceRequestCompletionBlock = (stockItems: NSArray?, error: NSError?) -> ()

public class DataManager {
   
    let URL = "http://api.money.126.net/data/feed/1000002,1000001,1002069,1000881,0600231,1300231,1300122,1300390,money.api"
    var priceArray = NSMutableArray()
    
    public func requestPrice(completion: PriceRequestCompletionBlock) {
        
        self.priceArray.removeAllObjects()
        
        let session = NSURLSession.sharedSession()
        
        let request = NSURLRequest(URL: NSURL(string: URL)!)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            if error == nil {
                var JSONError: NSError?
                let responseDict = NSJSONSerialization.JSONObjectWithData(self.filterResponseString(data), options: NSJSONReadingOptions.AllowFragments, error: &JSONError) as NSDictionary
                if JSONError == nil {
                    println(responseDict)
                    
                    for (key,dict) in responseDict {

                        let dic = dict as NSDictionary
                        
                        let stockItem = Stock(dict: dic)
                        
                        self.priceArray.addObject(stockItem)
                    }
                    
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(stockItems: self.priceArray, error: nil)
                    })
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in

                    })
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in

                })
            }
        })
        task.resume()
    }

    func filterResponseString(data : NSData) -> NSData{

        var string :String = NSString(data:data, encoding: NSUTF8StringEncoding)!
        var array = string.componentsSeparatedByString("(")
        string = array.last!
        array = string.componentsSeparatedByString(")")
        string = array.first!
        var data1 = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        return data1!;
    }
}

class Stock: NSObject {
    
    var stockName : String = ""
    var price : Double = 0.0
    var statusUP : Bool = false
    var updown : Double = 0
    
    init(dict : NSDictionary) {
        super.init()
        configureStock(dict)
    }
    
    func configureStock(dict : NSDictionary) {
        stockName = dict["name"] as String
        price = dict["price"] as Double
        updown = dict["updown"] as Double

        if updown >= 0 {
            statusUP = true
        }
    }
    
}

