//
//  ConsumptionFormInteractorImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 06..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ConsumptionFormInteractorImpl : ConsumptionFormInteractor {
    private static let kHourOffset = 4
    private static let kMinuteOffset = kHourOffset * kOneHourInMinutes
    private static let kDayInMinutes = 24 * kOneHourInMinutes
    
    private let consumptionRepository: ConsumptionRepository
    private let sessionRepository: SessionRepository
    private let drinkRepository: DrinkRepository
    
    init (sessionRepository: SessionRepository, consumptionRepository: ConsumptionRepository, drinkRepository: DrinkRepository) {
        self.consumptionRepository = consumptionRepository
        self.sessionRepository = sessionRepository
        self.drinkRepository = drinkRepository
    }
    
    func validateDrink(drink: String) -> ConsumptionFormValidationResult {
        if (drink == "") { return ConsumptionFormValidationResult.EMPTY }
        else { return ConsumptionFormValidationResult.SUCCESS }
    }
    
    func validateAlcohol(alcohol: Double?) -> ConsumptionFormValidationResult {
        if (alcohol == nil) { return ConsumptionFormValidationResult.EMPTY }
        else if (alcohol! < 0) { return ConsumptionFormValidationResult.NEGATIVE }
        else if (alcohol == 0.0) { return ConsumptionFormValidationResult.ZERO }
        else { return ConsumptionFormValidationResult.SUCCESS }
    }
    
    func validateQuantity(quantity: Double?) -> ConsumptionFormValidationResult {
        if (quantity == nil) { return ConsumptionFormValidationResult.EMPTY }
        else if (quantity! < 0) { return ConsumptionFormValidationResult.NEGATIVE }
        else if (quantity == 0.0) { return ConsumptionFormValidationResult.ZERO }
        else { return ConsumptionFormValidationResult.SUCCESS }
    }
    
    func resolveDate(currentDate: Date, newDate: Date) -> Date {
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)

        let timeDiff = Int(newDate.timeIntervalSince(currentDate))
        let timeDiffInMinutes = (timeDiff / 60) % 60
        
        var dayOffset = 0
        if (timeDiffInMinutes < ConsumptionFormInteractorImpl.kMinuteOffset) {
            dayOffset = -1
        } else if (timeDiffInMinutes > ConsumptionFormInteractorImpl.kDayInMinutes - ConsumptionFormInteractorImpl.kMinuteOffset) {
            dayOffset = 1
        }
        
        return calendar.date(byAdding: Calendar.Component.day, value: dayOffset, to: newDate) ?? newDate
    }
    
    func saveConsumption(
        drink: String,
        alcohol: Double,
        quantity: Double,
        unit: DrinkUnit,
        date: Date = Date()
    ) -> Completable {
    
        let consumption = Consumption(
            drink: drink,
            quantity: quantity,
            unit: unit,
            alcohol: alcohol,
            date: date
        )
    
        return sessionRepository.inProgressSession.map { (session: Session) -> String in session.id }
            .first()
            .map { $0! }
            .flatMapCompletable { (sessionId) -> Completable in
                self.consumptionRepository.saveConsumption(sessionId: sessionId, consumption: consumption)
            }
    }

    func saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit) -> Completable {
        return saveConsumption(drink: drink, alcohol: alcohol, quantity: quantity, unit: unit, date: Date())
    }
    
    func loadDrinks() -> Single<[Drink]> {
        return drinkRepository.getDrinks()
    }
}
