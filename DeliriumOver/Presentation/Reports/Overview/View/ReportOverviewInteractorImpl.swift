//
//  ReportOverviewInteractorImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ReportOverviewInteractorImpl: ReportOverviewInteractor {
    private let sessionRepository: SessionRepository
    private let alcoholCalculator: AlcoholCalculatorRxDecorator
    private lazy var loadSessionTask: Observable<Session> = loadInProgressSession().replay(1).autoconnect()
    private var sessionId: String?
    
    init(sessionRepository: SessionRepository, alcoholCalculator: AlcoholCalculatorRxDecorator) {
        self.sessionRepository = sessionRepository
        self.alcoholCalculator = alcoholCalculator
    }
    
    func loadSession() -> Observable<Session> {
        return loadSessionTask
    }
    
    func loadStatistics() -> Observable<Statistics> {
        return loadSession().flatMap { (session) -> Observable<Statistics> in
            Observable.zip(
                self.alcoholCalculator.calcTimeOfZeroBAC(session: session).asObservable(),
                self.alcoholCalculator.calcBloodAlcoholConcentration(session: session, date: dateProvider.currentDate).asObservable(),
                resultSelector: { (alcoholEliminationDate, bloodAlcoholConcentration) -> Statistics in
                    return Statistics(alcoholEliminationDate: alcoholEliminationDate, bloodAlcoholConcentration: bloodAlcoholConcentration)
            }
            )
        }.asObservable()
    }
    
    func loadRecords() -> Observable<[Record]> {
        return loadSession().flatMap { (session) ->Observable<[Record]> in
//            sessionRepository.getFriendsSessions(shareKey: session.shareKey)
//                .map { (sessions) -> R in
//                    <#code#>
//            }
            Single.zip(
                Single.just(session.name),
                self.alcoholCalculator.generateRecords(session: session)
            ).map { (name, data) -> Record in
                Record(name: name, data: data)
                }.asObservable().toArray()
        }
        //        sessionRepository.getFriendsSessions(session.shareKey)
        //            .onErrorReturnItem(emptyList<Session>())
        //            .firstElement()
        //            .filter { session.shared }
        //            .defaultIfEmpty(emptyList())
        //            .flattenAsFlowable { it }
        //            .startWith(session)
        //            .flatMapSingle {
        //                Single.zip(
        //                    just(it.name),
        //                    alcoholCalculator.generateRecords(it),
        //                    BiFunction<String, List<Data>, Record> { name, records -> Record(name, records) }
        //                )
        //            }
        //            .toList()
    }
    
    func saveSession(session: Session) -> Completable {
        return sessionRepository.update(session: session)
    }
    
    private func loadInProgressSession() -> Observable<Session> {
        if let sessionId = self.sessionId {
            return sessionRepository.loadSession(sessionId: sessionId)
        }
        return sessionRepository.inProgressSession
            .flatMap { (session) -> PrimitiveSequence<MaybeTrait, Session> in
                self.createNewSessionIfExpired(session: session)
        }
        .map { session -> String in session.id }
        .do(onNext: { (sessionId) in
            self.sessionId = sessionId
        })
            .asObservable()
            .flatMap { (sessionId) -> Observable<Session> in
                self.loadInProgressSession()
        }
        .ifEmpty(switchTo:
            createNewSession()
                .do(onSuccess: { (sessionId) in
                    self.sessionId = sessionId
                })
                .asObservable()
                .flatMap { (sessionId) -> Observable<Session> in
                    self.loadInProgressSession()
            }
        )
        
        
        
        //            .doOnSuccess { this.sessionId = it }
        //            .flatMapPublisher { loadSession(it) }
        //            .switchIfEmpty(
        //                createNewSession()
        //                    .doOnSuccess { this.sessionId = it }
        //                    .flatMapPublisher { loadSession(it) }
        
    }
    
    private func createNewSession() -> Single<String> {
        return sessionRepository.insert(session: Session(inProgress: true))
    }
    
    private func createNewSessionIfExpired(session: Session) -> Maybe<Session> {
        return alcoholCalculator.calcTimeOfZeroBAC(session: session)
            .flatMapMaybe{ (timeOfZeroBAC) -> PrimitiveSequence<MaybeTrait, Session> in
                if !session.consumptions.isEmpty && dateProvider.currentDate > timeOfZeroBAC {
                    var oldSession = session
                    var newSession = session.clone()
                    oldSession.inProgress = false
                    newSession.inProgress = true
                    self.sessionId = nil
                    return self.sessionRepository.update(session: oldSession)
                        .andThen(self.sessionRepository.insert(session: newSession))
                        .map({ (sessionId) -> Session in
                            newSession.id = sessionId
                            return newSession
                        })
                        .asMaybe()
                } else {
                    return Maybe.just(session)
                }
        }
        //    alcoholCalculator.calcTimeOfZeroBAC(session)
        //    .flatMapMaybe { timeOfZeroBAC ->
        //    if (session.consumptions.isNotEmpty() && DateProvider.currentDate.after(timeOfZeroBAC)) {
        //    val newSession = session.clone()
        //    session.inProgress = false
        //    newSession.inProgress = true
        //    sessionRepository.update(session)
        //    .andThen(sessionRepository.insert(newSession))
        //    .map {
        //    newSession.id = it
        //    newSession
        //    }
        //    } else {
        //    Maybe.just(session)
        //    }
    }
}
