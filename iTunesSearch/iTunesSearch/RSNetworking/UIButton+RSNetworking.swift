//
//  UIButton+RSNetworking.swift
//  iTunesSearch
//
//  Created by Jon Hoffman on 8/25/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit

extension UIButton {
    func setButtonImageForURL(url: NSString, placeHolder: UIImage, state: UIControlState) -> Void{
        self.setBackgroundImage(placeHolder, forState:state)
        setButtonImageForURL(url,state: state)
        
    }
    
    func setButtonImageForURL(url: NSString, state: UIControlState) -> Void {
        var url = NSURL.URLWithString(url)
        var client = RSURLRequest()
        client.imageFromURL(url, completionHandler: {(response : NSURLResponse!, image: UIImage!, error: NSError!) -> Void in
            self.setBackgroundImage(image, forState:state)

        })
    }
    
    func setButtonImageForRSTransaction(transaction:RSTransaction, placeHolder: UIImage, state: UIControlState) -> Void {
        self.setBackgroundImage(placeHolder, forState:state)
        setButtonImageForRSTransaction(transaction, state: state)
    }
    
    func setButtonImageForRSTransaction(transaction:RSTransaction, state: UIControlState) -> Void {
        var RSRequest = RSTransactionRequest();
        
        RSRequest.imageFromRSTransaction(transaction, completionHandler: {(response: NSURLResponse!, image: UIImage!, error: NSError!) -> Void in
            self.setBackgroundImage(image, forState:state)
        })
        
    }

}
