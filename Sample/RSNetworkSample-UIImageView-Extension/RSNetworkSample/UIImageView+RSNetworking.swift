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
        
        var url = NSURL.URLWithString(url)
        var client = RSNetworking()
        client.imageFromURL(url, completionHandler: {(response : NSURLResponse!, image: UIImage!, error: NSError!) -> Void in
            
            self.image = image;
            })
    }
    
    func setImageForURL(url: NSString) -> Void {
        var url = NSURL.URLWithString(url)
        var client = RSNetworking()
        client.imageFromURL(url, completionHandler: {(response : NSURLResponse!, image: UIImage!, error: NSError!) -> Void in
            
            self.image = image;
            })
    }
}