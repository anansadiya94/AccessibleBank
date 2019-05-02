//
//  BaseViewController.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 09/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let gradient: CAGradientLayer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
    }
    
    private func setBackgroundColor() {
        gradient.colors = [UIColor.colorGradient1.cgColor, UIColor.colorGradient2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
    }
}
