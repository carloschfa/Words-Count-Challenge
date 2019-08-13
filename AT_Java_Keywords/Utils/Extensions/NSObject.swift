//
//  NSObject.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 08/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// A string containing the name o the class
    public static var className: String {
        return NSStringFromClass(self)
            .components(separatedBy: ".")
            .last ?? NSStringFromClass(self)
    }
    
}
