//
//  PinNumberViewController.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 09/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class PinNumberViewController: BaseViewController, UITextFieldDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pinLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var ninebutton: UIButton!
    @IBOutlet weak var errorButton: UIButton!

    var pinArray = ["","","",""]
    var printedString = ""
    var buttonLastTappedTime = NSDate()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: UI management
    private func configureUI() {
        setLabels()
        setButtons()
    }
    
    private func setLabels() {
        titleLabel.textColor = .white
        pinLabel.textColor = .white
        pinLabel.accessibilityLabel = "Pin introducido es"
        resetPinNumber()
    }
    
    private func setButtons() {
        setOkButton()
        setCancelButton()
        setNumberButton(zeroButton, 0)
        setNumberButton(oneButton, 1)
        setNumberButton(twoButton, 2)
        setNumberButton(threeButton, 3)
        setNumberButton(fourButton, 4)
        setNumberButton(fiveButton, 5)
        setNumberButton(sixButton, 6)
        setNumberButton(sevenButton, 7)
        setNumberButton(eightButton, 8)
        setNumberButton(ninebutton, 9)
        setErrorButton()
    }

    private func setOkButton() {
        okButton.tintColor = .white
        okButton.backgroundColor = .green
        //okButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        okButton.addTarget(self, action: #selector(PinNumberViewController.okTapped), for: .touchUpInside)
    }
    
    private func setCancelButton() {
        cancelButton.tintColor = .white
        cancelButton.backgroundColor = .red
        //cancelButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        cancelButton.addTarget(self, action: #selector(PinNumberViewController.cancelTapped), for: .touchUpInside)
    }
    
    private func setNumberButton(_ numberButton: UIButton, _ tag: Int) {
        numberButton.tintColor = .white
        numberButton.backgroundColor = .colorSecondary
        //numberButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        numberButton.addTarget(self, action: #selector(PinNumberViewController.numberTapped(sender:)), for: .touchUpInside)
        numberButton.tag = tag
    }
    
    private func setErrorButton() {
        errorButton.setTitle("", for: .normal)
        errorButton.tintColor = .black
        errorButton.backgroundColor = UIColor.colorError
        errorButton.addTarget(self, action: #selector(PinNumberViewController.errorTapped), for: .touchUpInside)
        errorButton.isHidden = true
        errorButton.titleLabel?.numberOfLines = 1
        errorButton.titleLabel?.adjustsFontSizeToFitWidth = true
        errorButton.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        errorButton.titleLabel!.baselineAdjustment = .alignCenters
        errorButton.accessibilityTraits = .none
    }
    
    // MARK: UI events
    private func showError(errorCode: Int) {
        var errorMessage: String = ""
        switch errorCode {
        case 1:
            errorMessage = "Pin vacío! Introduzca su pin por favor"
        case 2:
            errorMessage = "Pin inválido! Introduzca el pin válido por favor"
        default:
            break
        }
        AccessibilityEvents.accessibleFocus(errorButton)
        errorButton.isHidden = false
        errorButton.accessibilityViewIsModal = true
        errorButton.accessibilityHint = "Pulse dos veces para cerrar este mensaje de error"
        errorButton.setTitle(errorMessage, for: .normal)
        errorButton.accessibilityLabel = errorMessage
    }
    
    private func resetPinNumber() {
        pinLabel.text = "- - - -"
        pinArray = ["","","",""]
        printedString = ""
    }
    
    private func canButtonBeTapped(nowTime: NSDate) -> Bool {
        var secondsBetweenTwoDates =  TimeInterval()
        secondsBetweenTwoDates = nowTime.timeIntervalSince(buttonLastTappedTime as Date)
        if (secondsBetweenTwoDates < 1) {
            return false
        } else {
            buttonLastTappedTime = nowTime
            return true
        }
    }
    
    // MARK: UI events management
    @objc func numberTapped(sender: UIButton) {
        if (canButtonBeTapped(nowTime: NSDate())) {
            pinArray.removeFirst()
            pinArray.append(String(sender.tag))
            printedString = pinArray.joined(separator:" ")
            pinLabel.text = "\(printedString)"
            AccessibilityEvents.accessibleNotification("Pin introducido es \(printedString)", 1)
            pinLabel.accessibilityLabel = "Pin introducido es \(printedString)"
        }
    }
    
    @objc func okTapped() {
        if printedString.isEmpty {
            //empty pin
            showError(errorCode: 1)
        }
        else if (printedString != Constants.validPin) {
            //invalid pin
            showError(errorCode: 2)
        } else {
            //valid pin
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let globalPositionViewController = storyBoard.instantiateViewController(withIdentifier: "GlobalPositionViewController") as! GlobalPositionViewController
            self.navigationController?.pushViewController(globalPositionViewController, animated: true)
        }
    }
    
    @objc func cancelTapped() {
        AccessibilityEvents.accessibleNotification("Se ha borrado el pin", 0.1)
        resetPinNumber()
    }
    
    @objc func errorTapped() {
        resetPinNumber()
        errorButton.setTitle("", for: .normal)
        errorButton.isHidden = true
        pinLabel.accessibilityLabel = "Pin introducido es"
    }
}
