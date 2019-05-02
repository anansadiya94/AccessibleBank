//
//  PersonalViewController.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 15/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit

class PersonalViewController: BaseViewController {
    @IBOutlet weak var personalAccountNumberLabel: UILabel!
    @IBOutlet weak var personalCurrentBalanceLabel: UILabel!
    @IBOutlet weak var inboxButton: SSBadgeButton!
    
    // Without Xib
//    var notificationsWXCustomControl = CustomControl(frame: CGRect(x: 8, y: 250, width: 1000, height: 31))
//    var comunicationsWXCustomControl = CustomControl(frame: CGRect(x: 8, y: 290, width: 1000, height: 31))
    
    //With Xib
    @IBOutlet var notificationsCustomControl: CustomControlXib!
    @IBOutlet var comunicationsCustomControl: CustomControlXib!
    
    var movementsData = [MovementsModel]()
    var personalCurrentBalance: String = ""

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureUI()
    }
    
    // MARK: Configure Data
    private func configureData() {
        getMovementsData()
    }
    
    private func getMovementsData() {
        movementsData = MovementsData.getMovementsData()
    }
    
    private func getPersonalCurrentBalance() -> Int {
        var personalCurrentBalance: Int = 0
        for movement in movementsData {
            personalCurrentBalance += Common.stringToInt(movement.amount)
        }
        return personalCurrentBalance
    }
    
    // MARK: UI management
    private func configureUI() {
        setLabels()
        setButtons()
        setCustomControls()
    }
    
    private func setLabels() {
        setPersonalAccountNumberLabel()
        setPersonalCurrentBalanceLabel()
    }
    
    private func setButtons() {
        setInboxButton()
    }
    
    private func setCustomControls() {
        setNotificationsCustomControl()
        setComunicationsCustomControl()
    }

    private func setNotificationsCustomControl() {
        notificationsCustomControl.setStatus(false)
        notificationsCustomControl.setTitle("Recibir publicidad")
        notificationsCustomControl.setFontSize(18)
        notificationsCustomControl.setColor(UIColor.white)
        //Without Xib
//        notificationsWXCustomControl.setSwitchStatus(false)
//        notificationsWXCustomControl.setLabelTitle("Recibir publicidad")
//        self.view.addSubview(notificationsWXCustomControl)
    }

    private func setComunicationsCustomControl() {
        comunicationsCustomControl.setStatus(false)
        comunicationsCustomControl.setTitle("Recibir comunicaciones bancarias")
        comunicationsCustomControl.setFontSize(18)
        comunicationsCustomControl.setColor(UIColor.white)
        //Without Xib
//        comunicationsWXCustomControl.setSwitchStatus(false)
//        comunicationsWXCustomControl.setLabelTitle("Recibir comunicaciones bancarias")
//        self.view.addSubview(comunicationsWXCustomControl)
    }
    
    private func setPersonalAccountNumberLabel() {
        personalAccountNumberLabel.textColor = UIColor.white
        let accountNumberString = UserDefaults.standard.string(forKey: "accountNumber")!
        personalAccountNumberLabel.text = accountNumberString
        personalAccountNumberLabel.accessibilityLabel = "El número de cuenta es:\(accountNumberString)"
    }
    
    private func setPersonalCurrentBalanceLabel() {
        var personalCurrentBalanceString: String = ""
        let getPersonalCurrentBalaceInt = getPersonalCurrentBalance()
        if (getPersonalCurrentBalaceInt > 0) {
            personalCurrentBalanceString = "+\(getPersonalCurrentBalaceInt)"
            personalCurrentBalanceLabel.textColor = Common.colorByNumberSign(getPersonalCurrentBalaceInt)
        } else if (getPersonalCurrentBalaceInt < 0) {
            personalCurrentBalanceString = "-\(getPersonalCurrentBalaceInt)"
            personalCurrentBalanceLabel.textColor = Common.colorByNumberSign(getPersonalCurrentBalaceInt)
        } else {
            personalCurrentBalanceString = "\(getPersonalCurrentBalaceInt)"
            personalCurrentBalanceLabel.textColor = Common.colorByNumberSign(getPersonalCurrentBalaceInt)
        }
        personalCurrentBalanceString += "€"
        personalCurrentBalanceLabel.text = personalCurrentBalanceString
        personalCurrentBalanceLabel.accessibilityLabel = "El saldo actual es: " + Common.amountAccessibilityLabel(personalCurrentBalanceString)
    }
    
    private func setInboxButton() {
        inboxButton.badgeEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 7)
        inboxButton.badge = "4"
        inboxButton.accessibilityLabel = "Mensajería, tiene usted cuatro mensajes."
        inboxButton.accessibilityHint = "Pulse dos veces para ver los mensajes."
    }
}
