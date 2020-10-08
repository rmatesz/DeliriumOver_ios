//
//  ConsumptionFormPresenter.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

protocol ConsumptionFormPresenter {
    
    func loadData()

    func onDrinkChanged(_ value: String)
    func onAlcoholChanged(_ value: Double)
    func onQuantityChanged(_ value: Double)
    func onDrinkUnitChanged(_ value: DrinkUnit)
    func onTimeChanged(_ value: Date)

    func onSaveClicked()
}
