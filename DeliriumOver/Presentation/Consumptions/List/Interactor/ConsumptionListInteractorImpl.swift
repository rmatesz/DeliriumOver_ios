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
            .flatMap { (_) -> Single<Session> in
                self.loadSession()
            }
            .map { (session) -> [Consumption] in
                session.consumptions
            }
    }

    public func loadFrequentlyConsumedDrinks() -> Observable<[Drink]> {
        return subject
            .flatMap({ (_) -> Single<[Drink]> in
                self.drinkRepository.getFrequentlyConsumedDrinks()
            })
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
        let getSessionId: Single<String>
        if (session != nil || sessionId != nil) {
            getSessionId = Single.just(session?.id ?? sessionId!)
        } else {
            getSessionId = loadSession().map( { (session) -> String in session.id } )
        }
        return getSessionId.flatMapCompletable({ (sessionId) -> Completable in
            self.consumptionRepository.saveConsumption(sessionId: sessionId, consumption: Consumption(drink: drink))
                .do(onCompleted: {
                    self.subject.onNext(nil)
                })
        })
    }
    
    private func loadSession() -> Single<Session> {
        let sessionLoader: Maybe<Session>
        if (sessionId == nil) {
            sessionLoader = sessionRepository.getInProgressSession()
        } else {
            sessionLoader = sessionRepository.getSession(sessionId: sessionId!)
        }
        return sessionLoader.ifEmpty(switchTo: Single.error(SimpleError.error(message: "Session can't be loaded!")))
            .do(onSuccess: { (session) in
                self.session = session
            })
    }
}
