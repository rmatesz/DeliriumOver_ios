//
//  DrinkRepositoryImpl.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class DrinkRepositoryImpl : DrinkRepository {
    private let sessionRepository: SessionRepository
    private let drinksDatabase: FirebaseDrinksDatabase
    
    init(sessionRepository: SessionRepository, drinksDatabase: FirebaseDrinksDatabase) {
        self.sessionRepository = sessionRepository
        self.drinksDatabase = drinksDatabase
    }
    
    func getDrinks() -> Single<[Drink]> {
        return drinksDatabase.getDrinks()
    }
    
    func getFrequentlyConsumedDrinks() -> Observable<[Drink]> {
        return sessionRepository.sessions
            .map {
                return $0.flattenConsumptions()
                    .groupByDrink()
                    .sortedByCount()
                    .map { $0.getLatest()! }
                    .map { Drink(consumption: $0) }
            }
    }
}

extension Array where Element == Session {
    func flattenConsumptions() -> [Consumption] {
        return self.flatMap { $0.consumptions }
    }
}

extension Array where Element == Consumption {
    func groupByDrink() -> [[Consumption]] {
        return Dictionary(grouping: self, by: { $0.drink }).map { $0.value }
    }

    func getLatest() -> Consumption? {
        return self.max(by: { (left, right) -> Bool in
            left.date < right.date
        })
    }
}

extension Array where Element == [Consumption] {
    func sortedByCount() -> [[Consumption]] {
        return self.sorted(by: { (lhs, rhs) -> Bool in
            lhs.count > rhs.count
        })
    }
}
