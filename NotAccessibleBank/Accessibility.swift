//
//  Accessibility.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 09/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation
import UIKit

class AccessibilityEvents {
    // MARK: Accessibility events
    func accessibleNotification(_ message: String, _ delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIAccessibility.post(notification: .announcement, argument: message)
        }
    }
    
    func accessibleFocus(_ control: UIControl?) {
        UIAccessibility.post(notification: .screenChanged, argument: control)
    }
}
