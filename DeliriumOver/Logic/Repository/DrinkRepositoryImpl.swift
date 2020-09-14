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
//    private let drinkTypeParser: DrinkTypeParser
    
    init(sessionRepository: SessionRepository, drinksDatabase: FirebaseDrinksDatabase) {
        self.sessionRepository = sessionRepository
        self.drinksDatabase = drinksDatabase
    }
    
    func getDrinks() -> Single<[Drink]> {
        return drinksDatabase.getDrinks()
    }
    
    func getFrequentlyConsumedDrinks() -> Observable<[Drink]> {
        return sessionRepository.sessions
            .map({ (it) -> [Drink] in
                return Dictionary(grouping: it
                    .flatMap({ (session) -> [Consumption] in
                        session.consumptions
                    }), by: {$0.drink})
                    .map({ (key, value) -> ([Consumption], Int) in
                        (value, value.count)
                    })
                    .sorted(by: { (left, right) -> Bool in
                        left.1 > right.1
                    })
                    .map({ (entry) -> Consumption in
                        entry.0.max(by: { (left, right) -> Bool in
                            left.date < right.date
                        })!
                    })
                    .map({ (consumption) -> Drink in
                        Drink(consumption: consumption)
                    })
            })
    }
}

