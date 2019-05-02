//
//  UIColorExtension.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 03/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static var colorPrimary: UIColor {
        get { return UIColor(hexString: "#1B1718") }
    }
    
    static var colorSecondary : UIColor {
        get { return UIColor(hexString: "#6699CC") }
    }
    
    static var colorGradient1 : UIColor {
        get { return UIColor(hexString: "#2C3E50") }
    }
    
    static var colorGradient2 : UIColor {
        get { return UIColor(hexString: "#BDC3C7") }
    }
    
    static var colorError : UIColor {
        get { return UIColor(hexString: "#F31431") }
    }
    
}

