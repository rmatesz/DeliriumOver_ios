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
        return sessionDAO.loadAll().map { (sessionEntities) -> [Session] in
            sessionEntities.map({ (sessionEntity) -> Session in
                Session(sessionEntity: sessionEntity)
            })
        }
    }
    
    func loadSession(sessionId: String) -> Observable<Session> {
        return sessionDAO.load(sessionId).map { (sessionEntity) -> Session in
            Session(sessionEntity: sessionEntity)
        }
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
        return sessionDAO.createEntity { (sessionEntity) -> () in
            sessionEntity.title = session.title
            sessionEntity.desc = session.description
            sessionEntity.name = session.name
            sessionEntity.weight = session.weight
            sessionEntity.gender = Int32(session.gender.rawValue)
            sessionEntity.inProgress = session.inProgress
        }
        .map { sessionEntity -> String in
            sessionEntity.objectID.uriRepresentation().absoluteString
        }
    }
    
    func update(session: Session) -> Completable {
        return sessionDAO.get(session.id)
            .ifEmpty(switchTo: Single.error(RepositoryError(message: "Can't find session in DB.")))
            .map { (sessionEntity) -> SessionEntity in
                sessionEntity.title = session.title
                sessionEntity.desc = session.description
                sessionEntity.name = session.name
                sessionEntity.weight = session.weight
                sessionEntity.gender = Int32(session.gender.rawValue)
                sessionEntity.inProgress = session.inProgress
                return sessionEntity
        }.flatMapCompletable { (sessionEntity) -> Completable in
            self.sessionDAO.save()
        }
    }
    
    func delete(session: Session) -> Completable {
        return sessionDAO.get(session.id)
            .ifEmpty(switchTo: Single.error(RepositoryError(message: "Can't find session in DB.")))
            .flatMapCompletable { (sessionEntity) -> Completable in
                self.sessionDAO.delete(sessionEntity)
        }
        
    }

    var inProgressSession: Observable<Session> {
        return sessionDAO.loadAll()
            .flatMap({ (entities) -> Observable<[SessionEntity]> in
                if entities.isEmpty {
                    Logger.i(category: "DATABASE", message: "No session found in DB, creating session...")
                    return self.createNewSession().asObservable().map { _ in entities }
                }
                return Observable.just(entities)
            })
            .filter({ (sessionEntities) -> Bool in
                let filter = sessionEntities.contains(where: { (sessionEntity) -> Bool in
                    sessionEntity.inProgress
                })
                if !filter {
                    Logger.w(category: "DATABASE", message: "No inProgress session found in DB --> result filtered out")
                }
                return filter
            })
            .map { (sessionEntities) -> SessionEntity in
                sessionEntities.first(where: { (sessionEntity) -> Bool in
                    sessionEntity.inProgress
                })!
        }
        .map { (sessionEntity) -> Session in
            Session(sessionEntity: sessionEntity)
        }
        .flatMap { (session) -> PrimitiveSequence<SingleTrait, Session> in
            self.createNewSessionIfExpired(session: session)
                .do(onSuccess: {
                    Logger.i(message: "In progress session loaded. \($0)")
                })
        }

    }
    
    func loadInProgressSession() -> Observable<Session> {
        return sessionDAO.loadAll()
            .filter { (sessionEntities) -> Bool in
                sessionEntities.contains(where: { (sessionEntity) -> Bool in
                    sessionEntity.inProgress
                })
        }
        .map { (sessionEntities) -> SessionEntity in
            sessionEntities.first(where: { (sessionEntity) -> Bool in
                sessionEntity.inProgress
            })!
        }
        .map { (sessionEntity) -> Session in
            Session(sessionEntity: sessionEntity)
        }
    }

    private func createNewSession() -> Single<String> {
        return insert(session: Session(inProgress: true))
    }

    private func createNewSessionIfExpired(session: Session) -> Single<Session> {
        return alcoholCalculator.calcTimeOfZeroBAC(session: session)
            .flatMap { (timeOfZeroBAC) -> PrimitiveSequence<SingleTrait, Session> in
                if !session.consumptions.isEmpty && dateProvider.currentDate > timeOfZeroBAC {
                    Logger.i(category: "DATABASE", message: "Alcohol is already eliminated. Creating new session...")
                    var oldSession = session
                    var newSession = session.clone()
                    oldSession.inProgress = false
                    newSession.inProgress = true
                    return self.update(session: oldSession)
                        .andThen(self.insert(session: newSession))
                        .map { (sessionId) -> Session in
                            newSession.id = sessionId
                            return newSession
                    }
                } else {
                    return Single.just(session)
                }
        }
    }
}
