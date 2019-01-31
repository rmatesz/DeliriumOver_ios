//
//  Consumption.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 30..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

public class Consumption {
    var id: Int64 = 0
    var drink: String = ""
    var quantity: Double = 0.0
    var unit: DrinkUnit = DrinkUnit.DL
    var alcohol: Double = 0.0
    var date: Date = dateProvider.currentDate

    init(drink: Drink) {
        if let drinkName = drink.localization[Locale.current.languageCode!] {
            self.drink = drinkName
        } else {
            self.drink = drink.name
        }
        self.quantity = drink.defaultQuantity
        self.unit = drink.defaultUnit
        self.alcohol = drink.alcohol

    }
}
