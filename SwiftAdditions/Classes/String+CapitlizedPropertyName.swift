//
//  String+CapitlizedPropertyName.swift
//  Atlas
//
//  Created by Robert Dougan on 03/11/15.
//  Copyright © 2015 Robert Dougan. All rights reserved.
//

import Foundation

public extension String {
    
    var capitalizedProperty: String {
        var string = self
        
        string = string.capitalizedString
        string = string.stringByReplacingOccurrencesOfString("_", withString: "")
        string.replaceRange(string.startIndex...string.startIndex, with: String(string[string.startIndex]).lowercaseString)
        
        return string
    }
    
}