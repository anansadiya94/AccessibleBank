//
//  MovementsData.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 15/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation
import UIKit

class MovementsData {
    static func getMovementsData() -> [MovementsModel] {
        var MovementsData = [MovementsModel]()
        MovementsData = [
            MovementsModel(date: "01/04/2019", movement: "Nómina WorldLine", amount: "+1000€"),
            MovementsModel(date: "02/04/2019", movement: "Línea Vodafone", amount: "-24€"),
            MovementsModel(date: "04/04/2019", movement: "Endesa electricidad", amount: "-54€")
        ]
        return MovementsData
    }
}
