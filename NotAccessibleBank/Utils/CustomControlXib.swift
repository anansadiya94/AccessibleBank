//
//  CustomControlXib.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 24/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation
import UIKit

class CustomControlXib: UIView {
    @IBOutlet var contentView: UIControl!
    @IBOutlet var customControlSwitch: UISwitch!
    @IBOutlet var customControlLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let _ = loadViewFromNib()
        contentView.addTarget(self, action: #selector(CustomControlXib.customControlTapped), for: .touchUpInside)
        configure()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "CustomControl", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
    
    @objc private func customControlTapped() {
        customControlSwitch?.setOn(!(customControlSwitch!.isOn), animated: true)
        self.accessibilityValue = customControlSwitch!.accessibilityValue
    }
    
    private func configure() {
        customControlLabel!.numberOfLines = 0
        customControlLabel!.isAccessibilityElement = false
        customControlSwitch!.isAccessibilityElement = false
        self.isAccessibilityElement = true
        self.accessibilityHint = customControlSwitch!.accessibilityHint
        self.accessibilityLabel = customControlLabel!.text
        self.accessibilityTraits = customControlSwitch!.accessibilityTraits
        self.accessibilityValue = customControlSwitch!.accessibilityValue
    }
    
    func setTitle(_ title: String) {
        if let customControlLabel = self.customControlLabel {
            customControlLabel.text = title
            self.accessibilityLabel = title
        }
    }
    
    func setFontSize(_ size: Int) {
        if let customControlLabel = self.customControlLabel {
            customControlLabel.font = customControlLabel.font.withSize(CGFloat(size))
        }
    }
    
    func setColor(_ color: UIColor) {
        if let customControlLabel = self.customControlLabel {
            customControlLabel.textColor = color
        }
    }
    
    func setTintColor(_ color: UIColor) {
        customControlSwitch.tintColor = color
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    func setStatus(_ status: Bool) {
        if let customControlSwitch = self.customControlSwitch {
            customControlSwitch.setOn(status, animated: true)
            self.accessibilityValue = customControlSwitch.accessibilityValue
        }
    }
}
