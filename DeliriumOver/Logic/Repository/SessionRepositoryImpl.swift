//
//  SessionRepositoryImpl.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 01..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import RxSwift

class SessionRepositoryImpl: SessionRepository {
    private let sessionDAO: SessionDAO
    private let firebaseCommunicator: FirebaseCommunicator
    private let alcoholCalculator: AlcoholCalculatorRxDecorator
    private let deviceId: String
    
    init(sessionDAO: SessionDAO, firebaseCommunicator: FirebaseCommunicator, alcoholCalculator: AlcoholCalculatorRxDecorator, deviceId: String) {
        self.sessionDAO = sessionDAO
        self.firebaseCommunicator = firebaseCommunicator
        self.alcoholCalculator = alcoholCalculator
        self.deviceId = deviceId
    }
    
    var sessions: Observable<[Session]> {
        return sessionDAO.loadAll()
    }
    
    func loadSession(sessionId: String) -> Observable<Session> {
        return sessionDAO.get(sessionId).asObservable()
    }
    
    func getFriendsSessions(shareKey: String) -> Observable<[Session]> {
        return firebaseCommunicator.getSessions(shareKey: shareKey)
            .map({ (it) -> [Session] in
                it.filter({ (session) -> Bool in
                    session.shared && session.deviceId != self.deviceId
                })
            })

        //.map { it.filter { session -> session.shared && session.deviceId != deviceId } }
    }
    
    func insert(session: Session) -> Single<String> {
        return sessionDAO.insert(session: session)
    }
    
    func update(session: Session) -> Completable {
        return sessionDAO.update(session: session)
    }

    var inProgressSession: Observable<Session> {
        return sessionDAO.loadAll().distinctUntilChanged()
            .filter({ (sessions) -> Bool in
                let filter = sessions.contains(where: { (session) -> Bool in
                    session.inProgress
                })
                return filter
            })
            .map { (sessions) -> Session in
                sessions.first(where: { (session) -> Bool in
                    session.inProgress
                })!
        }
    }

    
}
