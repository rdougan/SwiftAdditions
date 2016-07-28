//
//  Array+Unique.swift
//  Pods
//
//  Created by Robert Dougan on 20/07/16.
//
//

import Foundation

public extension Array where Element : Hashable {
    
    var unique: [Element] {
        return Array(Set(self))
    }
    
}
