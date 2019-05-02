//
//  ViewController.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 02/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class AccountNumberViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var checkNumberTextField: UITextField!
    @IBOutlet weak var banckIdentifierTextField: UITextField!
    @IBOutlet weak var branchIdentifierTextField: UITextField!
    @IBOutlet weak var bbanCheckDigitsTextField: UITextField!
    @IBOutlet weak var accountNumberTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: MDCButton!
    @IBOutlet weak var acceptButton: MDCButton!
    @IBOutlet weak var errorButton: MDCButton!
    
    let gradient: CAGradientLayer = CAGradientLayer()
    let accessibilityEvents = AccessibilityEvents()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: UI management
    private func configureUI() {
        setBackgroundColor()
        setNavigationBar()
        addGestureRecognizer()
        setLabels()
        setTextFields()
        setButtons()
        ibaoutletsDelegate()
    }
    
    private func setBackgroundColor() {
        gradient.colors = [UIColor.colorGradient1.cgColor, UIColor.colorGradient2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setNavigationBar() {
        navigationController!.navigationBar.barTintColor = UIColor.colorSecondary
        navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func addGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AccountNumberViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setLabels() {
        titleLabel.textColor = .white
        infoLabel.textColor = .white
        infoLabel.isHidden = true
    }
    
    private func setTextFields() {
        countryCodeTextField.textAlignment = .center
        checkNumberTextField.textAlignment = .center
        banckIdentifierTextField.textAlignment = .center
        branchIdentifierTextField.textAlignment = .center
        bbanCheckDigitsTextField.textAlignment = .center
        accountNumberTextField.textAlignment = .center
    }
    
    private func setButtons() {
        //cancel button
        cancelButton.tintColor = .white
        cancelButton.backgroundColor = .colorSecondary
        cancelButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        cancelButton.addTarget(self, action: #selector(AccountNumberViewController.cancelTapped), for: .touchUpInside)
        
        //accept button
        acceptButton.tintColor = .white
        acceptButton.backgroundColor = .colorSecondary
        acceptButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        acceptButton.addTarget(self, action: #selector(AccountNumberViewController.acceptTapped), for: .touchUpInside)
        
        //error button
        errorButton.tintColor = .black
        errorButton.backgroundColor = UIColor.colorError
        errorButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        errorButton.addTarget(self, action: #selector(AccountNumberViewController.errorTapped), for: .touchUpInside)
        errorButton.isHidden = true
        errorButton.titleLabel?.numberOfLines = 1
        errorButton.titleLabel?.adjustsFontSizeToFitWidth = true
        errorButton.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        errorButton.titleLabel!.baselineAdjustment = .alignCenters
        errorButton.accessibilityTraits = .none // This doesn't run... I know why ;-)
    }
    
    private func showError() {
        errorButton.isHidden = false
        errorButton.accessibilityHint = "Pulse dos veces para cerrar este mensaje de error"
        errorButton.accessibilityViewIsModal = true
        accessibilityEvents.accessibleFocus(errorButton)
    }
    
    private func ibaoutletsDelegate() {
        countryCodeTextField.delegate = self
        checkNumberTextField.delegate = self
        banckIdentifierTextField.delegate = self
        branchIdentifierTextField.delegate = self
        bbanCheckDigitsTextField.delegate = self
        accountNumberTextField.delegate = self
    }
    
    // MARK: UI events management
    @objc func acceptTapped() {
        accessibilityEvents.accessibleNotification("   ")
        if validateTextFields() {
            //TODO: go to the next viewcontroller
            print("Campos validados! - TODO OK")
        }
        else {
            showError()
        }
    }
    
    @objc func cancelTapped() {
        // We have to include a accessible notification about what is happening. You can *see* all fields are deleted
        accessibilityEvents.accessibleNotification("Se han borrado todos los datos", 0.1)
        countryCodeTextField.text = ""
        checkNumberTextField.text = ""
        banckIdentifierTextField.text = ""
        branchIdentifierTextField.text = ""
        bbanCheckDigitsTextField.text = ""
        accountNumberTextField.text = ""
    }
    
    @objc func errorTapped() {
        errorButton.isHidden = true
        openFirstNonCompleteTextField()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Fields validation
    private func validateTextFields() -> Bool {
        if (countryCodeTextField.text?.count != 2) {
            return false
        } else if (checkNumberTextField.text?.count != 2) {
            return false
        } else if (banckIdentifierTextField.text?.count != 4) {
            return false
        } else if (branchIdentifierTextField.text?.count != 4) {
            return false
        } else if (bbanCheckDigitsTextField.text?.count != 2) {
            return false
        } else if (accountNumberTextField.text?.count != 10) {
            return false
        }
        return true
    }
    
    private func openFirstNonCompleteTextField() {
        if (countryCodeTextField.text?.count != 2) {
            countryCodeTextField.becomeFirstResponder()
        } else if (checkNumberTextField.text?.count != 2) {
            checkNumberTextField.becomeFirstResponder()
        } else if (banckIdentifierTextField.text?.count != 4) {
            banckIdentifierTextField.becomeFirstResponder()
        } else if (branchIdentifierTextField.text?.count != 4) {
            branchIdentifierTextField.becomeFirstResponder()
        } else if (bbanCheckDigitsTextField.text?.count != 2) {
            bbanCheckDigitsTextField.becomeFirstResponder()
        } else if (accountNumberTextField.text?.count != 10) {
            accountNumberTextField.becomeFirstResponder()
        }
    }
    
    // MARK: TextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == countryCodeTextField {
            if (countryCodeTextField.text?.count)! == 1 {
                countryCodeTextField.resignFirstResponder()
                countryCodeTextField.keyboardType = .numberPad
                countryCodeTextField.becomeFirstResponder()
                accessibilityEvents.accessibleNotification(checkNumberTextField.accessibilityLabel!, 0.5)
            } else if (countryCodeTextField.text?.count)! >= 2 {
                checkNumberTextField.text = string
                checkNumberTextField?.becomeFirstResponder()
                accessibilityEvents.accessibleNotification("   ")
                return false
            }
        } else if textField == checkNumberTextField {
            if (checkNumberTextField.text?.count)! == 1 {
                accessibilityEvents.accessibleNotification(banckIdentifierTextField.accessibilityLabel!, 0.5)
            } else if (checkNumberTextField.text?.count)! >= 2 {
                banckIdentifierTextField?.text = string
                banckIdentifierTextField?.becomeFirstResponder()
                accessibilityEvents.accessibleNotification("   ")
                return false
            }
        } else if textField == banckIdentifierTextField {
            if (banckIdentifierTextField.text?.count)! == 3 {
                accessibilityEvents.accessibleNotification(branchIdentifierTextField.accessibilityLabel!, 0.5)
            } else if (banckIdentifierTextField.text?.count)! >= 4 {
                branchIdentifierTextField?.text = string
                branchIdentifierTextField?.becomeFirstResponder()
                accessibilityEvents.accessibleNotification("   ")
                return false
            }
        } else if textField == branchIdentifierTextField {
            if (branchIdentifierTextField.text?.count)! == 3 {
                accessibilityEvents.accessibleNotification(bbanCheckDigitsTextField.accessibilityLabel!, 0.5)
            } else if (branchIdentifierTextField.text?.count)! >= 4 {
                bbanCheckDigitsTextField?.text = string
                bbanCheckDigitsTextField?.becomeFirstResponder()
                accessibilityEvents.accessibleNotification("   ")
                return false
            }
        } else if textField == bbanCheckDigitsTextField {
            if (bbanCheckDigitsTextField.text?.count)! == 1 {
                accessibilityEvents.accessibleNotification(accountNumberTextField.accessibilityLabel!, 0.5)
            } else if (bbanCheckDigitsTextField.text?.count)! >= 2 {
                accountNumberTextField?.text = string
                accountNumberTextField?.becomeFirstResponder()
                accessibilityEvents.accessibleNotification("   ")
                return false
            }
        } else if textField == accountNumberTextField {
            if (accountNumberTextField.text?.count)! >= 10 {
                dismissKeyboard()
                acceptTapped()
                return false
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case countryCodeTextField:
            infoLabel.text = "Código del país"
        case checkNumberTextField:
            infoLabel.text = "Código de control"
        case banckIdentifierTextField:
            infoLabel.text = "Código del banco"
        case branchIdentifierTextField:
            infoLabel.text = "Código de la sucursal"
        case bbanCheckDigitsTextField:
            infoLabel.text = "Código de control"
        case accountNumberTextField:
            infoLabel.text = "Código de la cuenta"
        default:
            break
        }
        infoLabel.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        infoLabel.isHidden = true
    }
}
