//
//  ConsumptionListInteractor.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ConsumptionListInteractorImpl: ConsumptionListInteractor {
    private let sessionRepository: SessionRepository
    private let consumptionRepository: ConsumptionRepository
    private let drinkRepository: DrinkRepository
    private let sessionId: String?
    private var session: Session?
    private let subject: BehaviorSubject<Any?> = BehaviorSubject(value: nil)
    
    init(sessionRepository: SessionRepository, consumptionRepository: ConsumptionRepository, drinkRepository: DrinkRepository, sessionId: String? = nil) {
        self.sessionRepository = sessionRepository
        self.consumptionRepository = consumptionRepository
        self.drinkRepository = drinkRepository
        self.sessionId = sessionId
    }

    public func refresh() {
        subject.onNext(nil)
    }
    
    public func loadConsumptions() -> Observable<[Consumption]> {
        return subject
            .flatMap { (_) -> Observable<Session> in
                self.loadSession()
            }
            .map { (session) -> [Consumption] in
                session.consumptions
            }
    }

    public func loadFrequentlyConsumedDrinks() -> Observable<[Drink]> {
        return subject
            .flatMap { _ in
                self.drinkRepository.getFrequentlyConsumedDrinks()
            }
            .map({ (drinks) -> [Drink] in
                Array(drinks.prefix(3))
            })
    }
    
    public func delete(consumption: Consumption) -> Completable {
        return consumptionRepository
            .delete(consumption: consumption)
            .do(onCompleted: {
                self.subject.onNext(nil)
            })
    }
    
    public func add(drink: Drink) -> Completable {
        if let sessionId = session?.id ?? self.sessionId {
            return self.consumptionRepository.saveConsumption(sessionId: sessionId, consumption: Consumption(drink: drink))
                .do(onCompleted: {
                    self.subject.onNext(nil)
                })
        } else {
            return Completable.empty()
        }
    }
    
    private func loadSession() -> Observable<Session> {
        let sessionLoader: Observable<Session>
        if (sessionId == nil) {
            sessionLoader = sessionRepository.inProgressSession
        } else {
            sessionLoader = sessionRepository.loadSession(sessionId: sessionId!)
        }
        return sessionLoader
            .do(onNext: { (session) in
                self.session = session
            })
    }
}
