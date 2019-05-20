//
//  AccessibilityEvents.swift
//  MaterialComponents
//
//  Created by Anan Sadiya on 09/04/2019.
//

import Foundation
import UIKit

class AccessibilityEvents {
    class func accessibleNotification(_ message: String, _ delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIAccessibility.post(notification: .announcement, argument: message)
        }
    }
    
    class func accessibleFocus(_ control: Any?) {
        UIAccessibility.post(notification: .screenChanged, argument: control)
    }
}
