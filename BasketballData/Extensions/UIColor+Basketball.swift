//
//  UIColor+Basketball.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func fromRgb(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
    
    static func pgPosition () -> UIColor {
        return UIColor.fromRgb(0x34dabb)
    }
    
    static func sgPosition () -> UIColor {
        return UIColor.fromRgb(0x24bed0)
    }
    
    static func sfPosition () -> UIColor {
        return UIColor.fromRgb(0x19aadd)
    }
    
    static func pfPosition () -> UIColor {
        return UIColor.fromRgb(0x0b92ef)
    }
    
    static func cPosition () -> UIColor {
        return UIColor.fromRgb(0x007eff)
    }
}
