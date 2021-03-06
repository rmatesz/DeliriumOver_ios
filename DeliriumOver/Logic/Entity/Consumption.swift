//
//  Consumption.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 30..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

public struct Consumption: Equatable {
    var id: String = ""
    var drink: String = ""
    var quantity: Double = 0.0
    var unit: DrinkUnit = DrinkUnit.deciliter
    var alcohol: Double = 0.0
    var date: Date = dateProvider.currentDate

    init(
        _ id: String = "",
        drink: String = "",
        quantity: Double = 0.0,
        unit: DrinkUnit = DrinkUnit.deciliter,
        alcohol: Double = 0.0,
        date: Date = dateProvider.currentDate
    ) {
        self.id = id
        self.drink = drink
        self.quantity = quantity
        self.unit = unit
        self.alcohol = alcohol
        self.date = date
    }
    
    init(consumptionEntity: ConsumptionEntity) {
        self.id = consumptionEntity.objectID.uriRepresentation().absoluteString
        self.drink = consumptionEntity.drink ?? self.drink
        self.quantity = consumptionEntity.quantity
        self.unit = DrinkUnit(rawValue: Int(consumptionEntity.unit)) ?? self.unit
        self.alcohol = consumptionEntity.alcohol
        self.date = consumptionEntity.date ?? self.date
    }
    
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
