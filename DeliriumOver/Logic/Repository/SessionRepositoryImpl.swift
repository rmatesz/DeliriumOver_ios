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
    
    init(sessionDAO: SessionDAO) {
        self.sessionDAO = sessionDAO
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
    
    func getFriendsSessions(shareKey: String) -> Observable<[Session]> {
        return Observable.just([])
    }
    
    func insert(session: Session) -> Completable {
        let sessionEntity = sessionDAO.createEntity()
        sessionEntity.title = session.title
        sessionEntity.desc = session.description
        sessionEntity.name = session.name
        sessionEntity.weight = session.weight
        sessionEntity.gender = Int32(session.gender.rawValue)
        return sessionDAO.save()
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
            .flatMap({ (sessionEntities) -> Maybe<SessionEntity> in
                let sessionEntity = sessionEntities
                    .filter({ (sessionEntity) -> Bool in
                        sessionEntity.inProgress
                    })
                    .first
                if sessionEntity != nil {
                    return Maybe.just(sessionEntity!)
                } else {
                    return Maybe.empty()
                }
            })
            .map { (sessionEntity) -> Session in
                Session(sessionEntity: sessionEntity)
            }
    }
    
    
}
