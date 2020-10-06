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
    private let kHourOffset = 4
    private lazy var kMinuteOffset: Int = kHourOffset * kOneHourInMinutes
    private let kDayInMinutes = 24 * kOneHourInMinutes
    
    private let consumptionRepository: ConsumptionRepository
    private let sessionRepository: SessionRepository
    private let drinkRepository: DrinkRepository
    
    init (sessionRepository: SessionRepository, consumptionRepository: ConsumptionRepository, drinkRepository: DrinkRepository) {
        self.consumptionRepository = consumptionRepository
        self.sessionRepository = sessionRepository
        self.drinkRepository = drinkRepository
    }
    
    func validateDrink(drink: String) -> ConsumptionFormValidationResult {
        if (drink.isEmpty) {
            return ConsumptionFormValidationResult.EMPTY
        } else {
            return ConsumptionFormValidationResult.SUCCESS
        }
    }
    
    func validateAlcohol(alcohol: Double?) -> ConsumptionFormValidationResult {
        guard let alcohol = alcohol else {
            return ConsumptionFormValidationResult.EMPTY
        }
        if (alcohol < 0) {
            return ConsumptionFormValidationResult.NEGATIVE
        } else if (alcohol == 0.0) {
            return ConsumptionFormValidationResult.ZERO
        } else { return ConsumptionFormValidationResult.SUCCESS }
    }
    
    func validateQuantity(quantity: Double?) -> ConsumptionFormValidationResult {
        if (quantity == nil) {
            return ConsumptionFormValidationResult.EMPTY
        } else if (quantity! < 0) {
            return ConsumptionFormValidationResult.NEGATIVE
        } else if (quantity == 0.0) {
            return ConsumptionFormValidationResult.ZERO
        } else {
            return ConsumptionFormValidationResult.SUCCESS
        }
    }

    func resolveDate(currentDate: Date, newDate: Date) -> Date {
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)

        let timeDiff = Int(newDate.timeIntervalSince(currentDate))
        let timeDiffInMinutes = timeDiff / 60

        var dayOffset = 0
        if (timeDiffInMinutes > kMinuteOffset) {
            dayOffset = -1
        } else if (timeDiffInMinutes < kMinuteOffset - kDayInMinutes) {
            dayOffset = 1
        }

        return calendar.date(byAdding: Calendar.Component.day, value: dayOffset, to: newDate) ?? newDate
    }

    func saveConsumption(
        drink: String,
        alcohol: Double,
        quantity: Double,
        unit: DrinkUnit,
        date: Date = dateProvider.currentDate
    ) -> Completable {

        let consumption = Consumption(
            drink: drink,
            quantity: quantity,
            unit: unit,
            alcohol: alcohol,
            date: date
        )

        return sessionRepository
            .singleInProgressSession
            .map { (session: Session) -> String in session.id }
            .flatMapCompletable { (sessionId) -> Completable in
                self.consumptionRepository.saveConsumption(sessionId: sessionId, consumption: consumption)
            }
    }

    func saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit) -> Completable {
        return saveConsumption(drink: drink, alcohol: alcohol, quantity: quantity, unit: unit, date: dateProvider.currentDate)
    }

    func loadDrinks() -> Single<[Drink]> {
        return drinkRepository.getDrinks()
    }
}
