//
//  RWDActivityManager.swift
//  Pods
//
//  Created by Robert Dougan on 28/07/16.
//
//

import UIKit

public class RWDActivityManager: NSObject {
    
    public static let sharedInstance = RWDActivityManager()
    
    private var loadingCount: Int = 0
    
    public func append() {
        self.loadingCount = self.loadingCount + 1
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = self.loadingCount > 0
    }
    
    public func subtract() {
        self.loadingCount = self.loadingCount - 1
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = self.loadingCount > 0
    }
    
}

