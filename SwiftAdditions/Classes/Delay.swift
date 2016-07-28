//
//  Delay.swift
//  F45 Playbook
//
//  Created by Robert Dougan on 30/05/16.
//  Copyright © 2016 Robert Dougan. All rights reserved.
//

import Foundation

public func delay(delay: Double, closure:() -> ()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}