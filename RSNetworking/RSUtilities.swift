//
//  RSUtilities.swift
//  RSNetworkSample
//
//  Created by Jon Hoffman on 7/26/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit
import SystemConfiguration

class RSUtilities: NSObject {
    
    /*Checks to see if a host is reachable*/
    class func isHostnameReachable(hostname: NSString) -> Bool {
        
        var reachabilityRef = SCNetworkReachabilityCreateWithName(nil,hostname.UTF8String)
        
        var reachability = reachabilityRef.takeUnretainedValue()
        var flags: SCNetworkReachabilityFlags = 0
        SCNetworkReachabilityGetFlags(reachabilityRef.takeUnretainedValue(), &flags)
        
        return (flags & UInt32(kSCNetworkReachabilityFlagsReachable) != 0)
        
    }
   
}
