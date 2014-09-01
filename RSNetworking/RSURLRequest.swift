//
//  RSURLRequest.swift
//  RSNetworkSample
//
//  Created by Jon Hoffman on 7/25/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration


class RSURLRequest: NSObject {
    
    let dictKey = "results"
    
    typealias dataFromURLCompletionClosure = ((NSURLResponse!, NSData!, NSError!) -> Void)!
    typealias stringFromURLCompletionClosure = ((NSURLResponse!, NSString!, NSError!) -> Void)!
    typealias dictionaryFromURLCompletionClosure = ((NSURLResponse!, NSDictionary!, NSError!) -> Void)!
    typealias imageFromURLCompletionClosure = ((NSURLResponse!, UIImage!, NSError!) -> Void)!
    

    func dataFromURL(url : NSURL, completionHandler handler: dataFromURLCompletionClosure) {
        
        var queue = NSOperationQueue.currentQueue()
        var sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var request = NSURLRequest(URL:url)
        var urlSession = NSURLSession(configuration:sessionConfiguration, delegate: nil, delegateQueue: queue)
        
        var sessionTask: Void = urlSession.dataTaskWithRequest(request, completionHandler: {(responseData: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            
            handler(response,responseData,error)
            }).resume()
        
    }
    

    func stringFromURL(url : NSURL, completionHandler handler: stringFromURLCompletionClosure) {
        dataFromURL(url, completionHandler: {(response: NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
            
            var responseString = NSString(data: responseData, encoding: NSUTF8StringEncoding)
            handler(response,responseString,error)
            })
    }
    

    func dictionaryFromJsonURL(url : NSURL, completionHandler handler: dictionaryFromURLCompletionClosure) {
        dataFromURL(url, completionHandler: {(response: NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
            
            if error != nil {
                handler(response,nil,error)
                return
            }
            
            var resultDictionary = NSMutableDictionary()
            var jsonError : NSError?
            
            var jsonResponse : AnyObject = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments, error: &jsonError)!
            
            switch jsonResponse {
            case is NSDictionary:
                resultDictionary = jsonResponse as NSMutableDictionary
            case is NSArray:
                resultDictionary[self.dictKey] = jsonResponse
            default:
                resultDictionary[self.dictKey] = ""
            }
            handler(response,resultDictionary.copy() as NSDictionary,error)
            })
    }
    
    func imageFromURL(url : NSURL, completionHandler handler: imageFromURLCompletionClosure) {
        dataFromURL(url, completionHandler: {(response: NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
            
            if error != nil {
                handler(response,nil,error)
                return
            }
            
            var image = UIImage(data: responseData)
            handler(response,image.copy() as UIImage,error)
            })
    }

    
    
}
