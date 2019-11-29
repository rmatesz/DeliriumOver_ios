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
    private let deviceId: String
    
    init(sessionDAO: SessionDAO, firebaseCommunicator: FirebaseCommunicator, deviceId: String) {
        self.sessionDAO = sessionDAO
        self.firebaseCommunicator = firebaseCommunicator
        self.deviceId = deviceId
    }
    
    func getSessions() -> Maybe<[Session]> {
        return sessionDAO.getAll().map { (sessionEntities) -> [Session] in
            sessionEntities.map({ (sessionEntity) -> Session in
                Session(sessionEntity: sessionEntity)
            })
        }
    }

    func getSession(sessionId: String) -> Maybe<Session> {
        return sessionDAO.get(sessionId).map { (sessionEntity) -> Session in
            Session(sessionEntity: sessionEntity)
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
        var session = session
        return Single.deferred { () -> Single<SessionEntity> in
            let sessionEntity = self.sessionDAO.createEntity()
            sessionEntity.title = session.title
            sessionEntity.desc = session.description
            sessionEntity.name = session.name
            sessionEntity.weight = session.weight
            sessionEntity.gender = Int32(session.gender.rawValue)
            sessionEntity.inProgress = session.inProgress
            return Single.just(sessionEntity)
        }
            .flatMapCompletable { (sessionEntity) -> Completable in
                session.id = sessionEntity.objectID.uriRepresentation().absoluteString
                return self.sessionDAO.save()
            }
            .andThen(Single.deferred { () -> PrimitiveSequence<SingleTrait, String> in
                Single.just(session.id)
            })
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
    
    func getInProgressSession() -> Maybe<Session> {
        return sessionDAO.getAll()
            .filter({ (sessionEntities) -> Bool in
                sessionEntities.contains(where: { (sessionEntity) -> Bool in
                    sessionEntity.inProgress
                })
            })
            .map { (sessionEntities) -> SessionEntity in
                sessionEntities.first(where: { (sessionEntity) -> Bool in
                    sessionEntity.inProgress
                })!
            }
            .map { (sessionEntity) -> Session in
                Session(sessionEntity: sessionEntity)
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
}
