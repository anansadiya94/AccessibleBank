//
//  MovementsViewController.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 15/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit

class MovementsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var movementsData = [MovementsModel]()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
    
    // MARK: Configure Data
    private func configureData() {
        getMovementsData()
    }

    private func getMovementsData() {
        movementsData = MovementsData.getMovementsData()
    }
    
    // MARK: Table view events
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movementsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movementCell", for: indexPath) as! MovementTableViewCell
        let date = movementsData[indexPath.row].date
        let movement = movementsData[indexPath.row].movement
        let amount = movementsData[indexPath.row].amount
        cell.dateLabel.text = date
        cell.dateLabel.textColor = UIColor.white
        cell.movementLabel.text = movement
        cell.movementLabel.textColor = UIColor.white
        cell.amountLabel.text = amount
        cell.amountLabel.textColor = Common.colorByNumberSign(Common.stringToInt(amount))
        cell.accessibilityLabel = cellAccessibilityLabel(date, movement, amount)
        cell.accessibilityHint = "Pulse dos veces para ver los detalles del movimiento"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? MovementTableViewCell {
            if let destination = segue.destination as? MovementDetailViewController {
                destination.dateMovementDetail = cell.dateLabel.text!
                destination.amountMovementDetail = cell.amountLabel.text!
                destination.movementMovementDetail = cell.movementLabel.text!
            }
        }
    }
    
    private func cellAccessibilityLabel(_ date: String, _ movement: String, _ amount: String) -> String{
        if (Common.stringToInt(amount) < 0) {
            return date + movement + Common.amountAccessibilityLabel(amount)
        } else {
            return date + movement + Common.amountAccessibilityLabel(amount)
        }
    }
}
