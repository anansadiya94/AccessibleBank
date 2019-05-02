//
//  GlobalPositionViewController.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 15/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit

class GlobalPositionViewController: BaseViewController {
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var movementsButton: UIBarButtonItem!
    @IBOutlet weak var servicesButton: UIBarButtonItem!
    @IBOutlet weak var personalButton: UIBarButtonItem!
    
    var movementsViewController = MovementsViewController()
    var servicesViewController = ServicesViewController()
    var personalViewController = PersonalViewController()
    
    private var activeViewController : UIViewController?{
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: UI management
    private func configureUI() {
        setNavigationBar()
        setToolBar()
        setDefaultViewController()
        setToolBarButtonsccessibilityHint()
    }
    
    private func setNavigationBar() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Posición Global"
    }
    
    private func resetToolBarButtons() {
        movementsButton.tintColor = UIColor.white
        movementsButton.accessibilityTraits = .button
        servicesButton.tintColor = UIColor.white
        servicesButton.accessibilityTraits = .button
        personalButton.tintColor = UIColor.white
        personalButton.accessibilityTraits = .button
    }
    
    private func setToolBar() {
        toolbar.barTintColor = UIColor.colorPrimary
        toolbarView.accessibilityTraits = .tabBar
        selectedToolBarButton(movementsButton)
    }
    
    private func setDefaultViewController() {
        movementsViewController = storyboard!.instantiateViewController(withIdentifier: "MovementsViewController") as! MovementsViewController
        activeViewController = movementsViewController
    }
    
    private func setToolBarButtonsccessibilityHint() {
        movementsButton.accessibilityHint = "Pulse dos veces para ver los movemientos de tu cuenta"
        servicesButton.accessibilityHint = "Pulse dos veces para ver los servicios que se ofrecen para tu cuenta"
        personalButton.accessibilityHint = "Pulse dos veces para ver su información personal"
    }
    
    private func selectedToolBarButton(_ selectedButton: UIBarButtonItem) {
        resetToolBarButtons()
        selectedButton.tintColor = UIColor.colorPrimary
        selectedButton.accessibilityTraits = .selected
        AccessibilityEvents.accessibleFocus(selectedButton)
    }
    
    // MARK: UI events
    @IBAction func movementsTapped(_ sender: Any) {
        activeViewController = movementsViewController
        AccessibilityEvents.accessibleFocus(contentView as? UIControl)
        selectedToolBarButton(movementsButton)
    }
    
    @IBAction func servicesTapped(_ sender: Any) {
        servicesViewController = storyboard!.instantiateViewController(withIdentifier: "ServicesViewController") as! ServicesViewController
        activeViewController = servicesViewController
        AccessibilityEvents.accessibleFocus(contentView as? UIControl)
        selectedToolBarButton(servicesButton)
    }
    
    @IBAction func personalTapped(_ sender: Any) {
        personalViewController = storyboard!.instantiateViewController(withIdentifier: "PersonalViewController") as! PersonalViewController
        activeViewController = personalViewController
        AccessibilityEvents.accessibleFocus(contentView as? UIControl)
        selectedToolBarButton(personalButton)
    }
    
    //MARK: Container events management
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inactiveVC = inactiveViewController {
            // warning the child view controller that we are going to eliminate it from its content
            inactiveVC.willMove(toParent: nil)
            
            // deleting the child view controller
            inactiveVC.view.removeFromSuperview()
            
            // finalizing the relationship between the content and the child view controller
            inactiveVC.removeFromParent()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            // starting the relationship between the content and the child view contoller
            addChild(activeVC)
            
            // setting the size and position of the child view controller
            activeVC.view.frame = contentView.bounds
            
            // adding the view of the child view controller
            contentView.addSubview(activeVC.view)
            
            // notifying the child view controller that we have mad the change
            activeVC.didMove(toParent: self)
        }
    }
}
