//
//  NSObject+Convenience.swift
//  FBH
//
//  Created by Miguel Angel Adan Roman on 1/4/17.
//  Copyright © 2017 Avantiic. All rights reserved.
//

import Foundation

extension NSObject {
    
    /**
     Returns the name of the class.
     
     - Returns: The `String` value of the class' raw name.
     
     */
    public class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    
    /**
     Returns the name of the instance's class.
     
     - Returns: The `String` value of the class' raw name.
     
     */
    public var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
}
