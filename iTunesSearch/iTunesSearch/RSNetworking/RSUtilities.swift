//
//  RSUtilities.swift
//  RSNetworkSample
//
//  Created by Jon Hoffman on 7/26/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit
import SystemConfiguration

public class RSUtilities: NSObject {
    
    public enum ConnectionType {
        case NONETWORK
        case MOBILE3GNETWORK
        case WIFINETWORK
    }
    
    /*isHostReachable will be depreciated in the future as it does not reflect
    *What is actually being done
    */
    
    public class func isHostnameReachable(hostname: NSString) -> Bool {
        return isNetworkAvailable(hostname);
    }
    /*Checks to see if a host is reachable*/
    public class func isNetworkAvailable(hostname: NSString) -> Bool {
        
        var reachabilityRef = SCNetworkReachabilityCreateWithName(nil,hostname.UTF8String)
        
        var reachability = reachabilityRef.takeUnretainedValue()
        var flags: SCNetworkReachabilityFlags = 0
        SCNetworkReachabilityGetFlags(reachabilityRef.takeUnretainedValue(), &flags)
        
        return (flags & UInt32(kSCNetworkReachabilityFlagsReachable) != 0)
        
    }
    
    /*Determines the type of network which is available*/
    public class func networkConnectionType(hostname: NSString) -> ConnectionType {
        
        var reachabilityRef = SCNetworkReachabilityCreateWithName(nil,hostname.UTF8String)
        
        var reachability = reachabilityRef.takeUnretainedValue()
        var flags: SCNetworkReachabilityFlags = 0
        SCNetworkReachabilityGetFlags(reachabilityRef.takeUnretainedValue(), &flags)
        
        var reachable: Bool = (flags & UInt32(kSCNetworkReachabilityFlagsReachable) != 0)
        var needsConnection: Bool = (flags & UInt32(kSCNetworkReachabilityFlagsConnectionRequired) != 0)
        if reachable && !needsConnection {
            // determine what type of connection is available
            var isCellularConnection = (flags & UInt32(kSCNetworkReachabilityFlagsIsWWAN) != 0)
            if isCellularConnection {
                return ConnectionType.MOBILE3GNETWORK // cellular connection available
            } else {
                return ConnectionType.WIFINETWORK // wifi connection available
            }
        }
        return ConnectionType.NONETWORK // no connection at all
    }

   
}
