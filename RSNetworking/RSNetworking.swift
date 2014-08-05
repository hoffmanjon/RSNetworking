//
//  RSNetworking.swift
//
//  Created by Jon Hoffman on 7/12/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

let dictKey = "results"

/*This class will be depreciated very soon, do not use anymore */
class RSNetworking: NSObject {
    
    enum ConnectionType {
        case NOCONNECTION
        case WIFINETWORK
        case MOBILENETWORK
        case REACHABLE
    }
    
    var queue: NSOperationQueue
    var sessionConfiguration: NSURLSessionConfiguration
    
    typealias dataFromURLCompletionClosure = ((NSURLResponse!, NSData!, NSError!) -> Void)!
    typealias stringFromURLCompletionClosure = ((NSURLResponse!, NSString!, NSError!) -> Void)!
    typealias dictionaryFromURLCompletionClosure = ((NSURLResponse!, NSDictionary!, NSError!) -> Void)!
    typealias imageFromURLCompletionClosure = ((NSURLResponse!, UIImage!, NSError!) -> Void)!
    
    override init() {
        queue = NSOperationQueue.currentQueue()
        sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    }
    
    /* Depreciated */
    /*This function will be removed in the near fucture, use the function in RSURLRequest */
    func dataFromURL(url : NSURL, completionHandler handler: dataFromURLCompletionClosure) {
        var request = NSURLRequest(URL:url)
        var urlSession = NSURLSession(configuration:sessionConfiguration, delegate: nil, delegateQueue: queue)
        
        var sessionTask: Void = urlSession.dataTaskWithRequest(request, completionHandler: {(responseData: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            
            handler(response,responseData,error)
            }).resume()
        
    }
    
    /* Depreciated */
    /*This function will be removed in the near fucture, use the function in RSURLRequest */
    func stringFromURL(url : NSURL, completionHandler handler: stringFromURLCompletionClosure) {
        dataFromURL(url, completionHandler: {(response: NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
            
            var responseString = NSString(data: responseData, encoding: NSUTF8StringEncoding)
            handler(response,responseString,error)
            })
    }
    
    /* Depreciated */
    /*This function will be removed in the near fucture, use the function in RSURLRequest */
    func dictionaryFromJsonURL(url : NSURL, completionHandler handler: dictionaryFromURLCompletionClosure) {
        dataFromURL(url, completionHandler: {(response: NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
            
            if error != nil {
                handler(response,nil,error)
                return
            }
            
            var resultDictionary = NSMutableDictionary()
            var jsonError : NSError?
            
            var jsonResponse : AnyObject = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments, error: &jsonError)
            
            switch jsonResponse {
            case is NSDictionary:
                resultDictionary = jsonResponse as NSMutableDictionary
            case is NSArray:
                resultDictionary[dictKey] = jsonResponse
            default:
                resultDictionary[dictKey] = ""
            }
            handler(response,resultDictionary.copy() as NSDictionary,error)
            })
    }
    
    /* Depreciated */
    /*This function will be removed in the near fucture, use the function in RSURLRequest */
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
    
    /* Depreciated */
    /*This function will be removed in the near fucture, use the function in RSUtilities */
    func isHostnameReachable(hostname: NSString) -> Bool {

        var reachabilityRef = SCNetworkReachabilityCreateWithName(nil,hostname.UTF8String)
            
        var reachability = reachabilityRef.takeUnretainedValue()
        var flags: SCNetworkReachabilityFlags = 0
        SCNetworkReachabilityGetFlags(reachabilityRef.takeUnretainedValue(), &flags)

        return (flags & UInt32(kSCNetworkReachabilityFlagsReachable) != 0)
        
    }
    
    
}
