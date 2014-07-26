//
//  UIImageView+RSNetworking.swift
//  RSNetworkSample
//
//  Created by Jon Hoffman on 7/14/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageForURL(url: NSString, placeHolder: UIImage) -> Void{
        
        self.image = placeHolder;
        setImageForURL(url)
        
    }
    
    func setImageForURL(url: NSString) -> Void {
        var url = NSURL.URLWithString(url)
        var client = RSNetworking()
        client.imageFromURL(url, completionHandler: {(response : NSURLResponse!, image: UIImage!, error: NSError!) -> Void in
            
            self.image = image
            })
    }
    
    func setImageForRSTransaction(transaction:RSTransaction, placeHolder: UIImage) -> Void {
        self.image = placeHolder
        setImageForRSTransaction(transaction)
    }
    
    func setImageForRSTransaction(transaction:RSTransaction) -> Void {
        var RSRequest = RSTransactionRequest();
        
        RSRequest.imageFromRSTransaction(transaction, completionHandler: {(response: NSURLResponse!, image: UIImage!, error: NSError!) -> Void in
            self.image = image
            })
        
      }
}