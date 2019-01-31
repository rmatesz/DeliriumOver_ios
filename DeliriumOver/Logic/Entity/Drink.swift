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
    var name: String = ""
    var alcohol: Double = 0.0
    var defaultQuantity: Double = 0.0
    var defaultUnit: DrinkUnit = DrinkUnit.DL
    var drinkType: DrinkType = DrinkType.UNKNOWN
    var localization: [String: String] = [:]
    
    init(consumption: Consumption) {
        name = consumption.drink
        alcohol = consumption.alcohol
        defaultQuantity = consumption.quantity
        defaultUnit = consumption.unit
    }
}
