//
//  Drink.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 30..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

struct Drink {
    var id: Int = -1
    let name: String
    let alcohol: Double
    let defaultQuantity: Double
    let defaultUnit: DrinkUnit
    let drinkType: DrinkType
    let localization: [String: String]
    
    init(consumption: Consumption) {
        self.init(
            name: consumption.drink,
            alcohol: consumption.alcohol,
            defaultQuantity: consumption.quantity,
            defaultUnit: consumption.unit
        )
    }

    init(name: String = "", alcohol: Double = 0.0, defaultQuantity: Double = 0.0, defaultUnit: DrinkUnit = DrinkUnit.DL, drinkType: DrinkType = DrinkType.UNKNOWN, localization: [String: String] = [:]) {
        self.name = name
        self.alcohol = alcohol
        self.defaultQuantity = defaultQuantity
        self.defaultUnit = defaultUnit
        self.drinkType = drinkType
        self.localization = localization
    }
}
