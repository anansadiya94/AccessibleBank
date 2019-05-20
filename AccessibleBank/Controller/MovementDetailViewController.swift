//
//  MovementDetailViewController.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 15/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit

class MovementDetailViewController: BaseViewController {
    @IBOutlet weak var dateMovementDetailLabel: UILabel!
    @IBOutlet weak var amountMovementDetailLabel: UILabel!
    @IBOutlet weak var movementMovementDetailLabel: UILabel!
    
    var dateMovementDetail: String = ""
    var amountMovementDetail: String = ""
    var movementMovementDetail: String = ""
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
    
    // MARK: Configure Data
    private func configureData() {
        configureMovementDetailData()
    }
    
    // MARK: UI management
    private func configureMovementDetailData() {
        configureDateMovementDetailLabel()
        configureAmountMovementDetailLabel()
        configureMovementMovementDetailLabel()
    }
    
    private func configureDateMovementDetailLabel() {
        dateMovementDetailLabel.textColor = UIColor.white
        dateMovementDetailLabel.text = dateMovementDetail
        dateMovementDetailLabel.accessibilityLabel = "La fecha del movimiento es:\(dateMovementDetail)"
    }
    
    private func configureAmountMovementDetailLabel() {
        amountMovementDetailLabel.textColor = Common.colorByNumberSign(Common.stringToInt(amountMovementDetail))
        amountMovementDetailLabel.text = amountMovementDetail
        amountMovementDetailLabel.accessibilityLabel = "El importe del movimiento es:" + Common.amountAccessibilityLabel(amountMovementDetail)
    }
    
    private func configureMovementMovementDetailLabel() {
        movementMovementDetailLabel.textColor = UIColor.white
        movementMovementDetailLabel.text = movementMovementDetail
    }
}
