//
//  CustomControl.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 23/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation
import UIKit

class CustomControl: UIControl {
    private var customControlSwitch: UISwitch?
    private var customControlLabel: UILabel?
    
    override init(frame: CGRect) {
        customControlSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        customControlLabel = UILabel(frame: CGRect(x: 70, y: 0, width: frame.size.width, height: frame.size.height))
        super.init(frame: frame)
        self.addTarget(self, action: #selector(CustomControl.customControlTapped), for: .touchUpInside)
        self.addSubview(customControlSwitch!)
        self.addSubview(customControlLabel!)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func customControlTapped() {
        customControlSwitch?.setOn(!(customControlSwitch!.isOn), animated: true)
        self.accessibilityValue = customControlSwitch!.accessibilityValue
    }
    
    private func configure() {
        customControlLabel!.textColor = .white
        customControlSwitch!.isAccessibilityElement = false
        customControlLabel!.isAccessibilityElement = false
        self.isAccessibilityElement = true
        self.accessibilityHint = customControlSwitch!.accessibilityHint
        self.accessibilityLabel = customControlLabel!.text
        self.accessibilityTraits = customControlSwitch!.accessibilityTraits
        self.accessibilityValue = customControlSwitch!.accessibilityValue
    }
    
    func setLabelTitle(_ title: String) {
        if let customControlLabel = self.customControlLabel {
            customControlLabel.text = title
            self.accessibilityLabel = title
        }
    }
    
    func setSwitchStatus(_ status: Bool) {
        if let customControlSwitch = self.customControlSwitch {
            customControlSwitch.setOn(status, animated: true)
            self.accessibilityValue = customControlSwitch.accessibilityValue
        }
    }
}
