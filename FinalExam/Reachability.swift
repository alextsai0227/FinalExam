//
//  Reachability.swift
//  FinalExam
//
//  Created by 蔡舜珵 on 2016/7/22.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//
import Foundation
import SystemConfiguration

func connectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    
    zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
    
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
        SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
    }) else {
        return false
    }
    var flags : SCNetworkReachabilityFlags = []
    
    if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
        
        return false
        
    }
    
    let isReachable = flags.contains(.Reachable)
    
    let needsConnection = flags.contains(.ConnectionRequired)
    
    return (isReachable && !needsConnection)
    
}