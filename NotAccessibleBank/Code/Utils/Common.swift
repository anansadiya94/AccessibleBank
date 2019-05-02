//
//  Common.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 15/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation
import UIKit

class Common {
    class func stringToInt(_ string: String) -> Int {
        return (string as NSString).integerValue
    }
    
    class func amountAccessibilityLabel(_ amount: String) -> String {
        let amountInt = stringToInt(amount)
        if (amountInt < 0) {
            return "menos \(amountInt) euros"
        } else if (amountInt > 0){
            return "más \(amountInt) euros"
        } else {
            return "\(amountInt) euros"
        }
    }
    
    class func colorByNumberSign(_ number: Int) -> UIColor {
        if (number > 0) {
            return UIColor.green
        } else if (number < 0) {
            return UIColor.red
        }
        return UIColor.white
    }
}
