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
        return loadSession().flatMap { (session) ->Single<[Record]> in
//            sessionRepository.getFriendsSessions(shareKey: session.shareKey)
//                .map { (sessions) -> R in
//
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
        
        
        
        //            .doOnSuccess { this.sessionId = it }
        //            .flatMapPublisher { loadSession(it) }
        //            .switchIfEmpty(
        //                createNewSession()
        //                    .doOnSuccess { this.sessionId = it }
        //                    .flatMapPublisher { loadSession(it) }
        
    }
}
