//
//  ConsumptionFormInteractor.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol ConsumptionFormInteractor {
    func loadDrinks() -> Single<[Drink]>
    func saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit) -> Completable
    func saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit, date: Date) -> Completable
    
    func validateDrink(drink: String) -> ConsumptionFormValidationResult
    func validateAlcohol(alcohol: Double?) -> ConsumptionFormValidationResult
    func validateQuantity(quantity: Double?) -> ConsumptionFormValidationResult
    func resolveDate(currentDate: Date, newDate: Date) -> Date
}

enum ConsumptionFormValidationResult {
    case SUCCESS, EMPTY, ZERO, NEGATIVE
}
