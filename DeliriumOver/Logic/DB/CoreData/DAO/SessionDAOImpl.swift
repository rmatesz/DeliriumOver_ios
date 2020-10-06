//
//  SessionDAOImpl.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class SessionDAOImpl: DAOImpl, SessionDAO {

    func loadAll() -> Observable<[Session]> {
        return Observable<[Session]>.create { (observer) -> Disposable in
            self.emit(observer)

            let contextObserver = { (notification: Notification) in
                self.emit(observer)
            }

            let contextObjectsDidChangeObserver = NotificationCenter.default.addObserver(forName: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil, queue: OperationQueue.current, using: contextObserver)
            let contextObjectsDidSaveObserver = NotificationCenter.default.addObserver(forName: Notification.Name.NSManagedObjectContextDidSave, object: nil, queue: OperationQueue.current, using: contextObserver)
            return Disposables.create {
                NotificationCenter.default.removeObserver(contextObjectsDidChangeObserver)
                NotificationCenter.default.removeObserver(contextObjectsDidSaveObserver)
            }
        }.distinctUntilChanged()
    }

    private func emit(_ observer: AnyObserver<[Session]>) {
        let fetch = { () -> [SessionEntity] in
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SessionEntity")
            request.returnsObjectsAsFaults = false

            let result = try super.context.fetch(request)
            return result as! [SessionEntity]
        }

        DispatchQueue.main.async {
            do {
                let result = try fetch().map { (entity) -> Session in
                    Session(sessionEntity: entity)
                }
                observer.onNext(result)
            } catch {
                observer.onError(error)
            }
        }
    }

    func get(_ sessionId: String) -> Maybe<Session> {
        return loadAll().first().flatMapMaybe({ (sessions) -> Maybe<Session> in
            let session = sessions?.first(where: { (session) -> Bool in
                session.id == sessionId
            })
            guard let safeSession = session else {
                return Maybe.empty()
            }
            return Maybe.just(safeSession)

        })
    }

    func insert(session: Session) -> Single<String> {
        return createEntity { sessionEntity in
            sessionEntity.title = session.title
            sessionEntity.desc = session.description
            sessionEntity.name = session.name
            sessionEntity.weight = session.weight
            sessionEntity.gender = Int32(session.gender.rawValue)
            sessionEntity.inProgress = session.inProgress
        }.map { (sessionEntity) -> String in
            sessionEntity.objectID.uriRepresentation().absoluteString
        }
    }

    func update(session: Session) -> Completable {
        let getSession: Maybe<SessionEntity> = getEntity(id: session.id)
        return getSession
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
            self.save()
        }
    }

    private func createEntity(fillEntity: @escaping (SessionEntity) -> ()) -> Single<SessionEntity> {
        return Single<SessionEntity>.create { (observer) -> Disposable in
            DispatchQueue.main.async {
                let sessionEntity = NSEntityDescription.insertNewObject(forEntityName: "SessionEntity", into: super.context) as! SessionEntity

                fillEntity(sessionEntity)
                do {

                    try self.context.obtainPermanentIDs(for: [sessionEntity])
                    try super.context.save()
                    observer(SingleEvent.success(sessionEntity))
                } catch {
                    observer(SingleEvent.error(error))
                }
            }
            return Disposables.create()
        }
        
    }
    
    
}
