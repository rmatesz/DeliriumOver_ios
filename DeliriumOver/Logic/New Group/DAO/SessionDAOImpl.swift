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

class SessionDAOImpl: SessionDAO {
    private var context: NSManagedObjectContext {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
        }
    }

    func loadAll() -> Observable<[SessionEntity]> {
        return Observable<[SessionEntity]>.create { (observer) -> Disposable in
            let contextObjectsDidChangeObserver = NotificationCenter.default.addObserver(forName: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil, queue: OperationQueue.current, using: { (notification) in
                do {
                    observer.onNext(try self.getAllSync())
                } catch {
                    observer.onError(error)
                }
            })
            let contextDidSaveObserver = NotificationCenter.default.addObserver(forName: Notification.Name.NSManagedObjectContextDidSave, object: nil, queue: OperationQueue.current, using: { (notification) in
                do {
                    observer.onNext(try self.getAllSync())
                } catch {
                    observer.onError(error)
                }
            })
            return Disposables.create {
                NotificationCenter.default.removeObserver(contextObjectsDidChangeObserver)
                NotificationCenter.default.removeObserver(contextDidSaveObserver)
            }
        }
    }
    
    func conextObjectsDidChange(_ notification: Notification, observer: AnyObserver<[SessionEntity]>) {
    }
    
    func getAll() -> Maybe<[SessionEntity]> {
        return Maybe<[SessionEntity]>.create { (observer: (MaybeEvent<[SessionEntity]>) -> ()) -> Disposable in

            do {
                let sessions = try self.getAllSync()
                observer(MaybeEvent.success(sessions))
            } catch {
                observer(MaybeEvent.error(error))
            }
            return Disposables.create()
        }
    }
    
    func getAllSync() throws -> [SessionEntity] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SessionEntity")
        request.returnsObjectsAsFaults = false
        
        let result = try self.context.fetch(request)
        return result as! [SessionEntity]
    }
    
    func get(_ sessionId: String) -> Maybe<SessionEntity> {
        return Maybe<SessionEntity>.create { (observer: (MaybeEvent<SessionEntity>) -> ()) -> Disposable in
            let objectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: URL(string: sessionId)!)
            
            if (objectId == nil) {
                observer(.completed)
            } else {
                do {
                    let sessionEntity = try self.context.existingObject(with: objectId!) as! SessionEntity
                        observer(.success(sessionEntity))
                } catch {
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func delete(_ session: SessionEntity) -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            do {
                try self.deleteSync(session)
                observer(CompletableEvent.completed)
            } catch {
                observer(CompletableEvent.error(error))
            }
            return Disposables.create()
        })
    }
    
    func deleteSync(_ session: SessionEntity) throws {
        context.delete(session)
        try context.save()
    }
    
    func deleteAll() -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            do {
                let sessions = try self.getAllSync()
                for session in sessions {
                    self.context.delete(session)
                }
                try self.context.save()
                observer(CompletableEvent.completed)
            } catch {
                observer(CompletableEvent.error(error))
            }
            return Disposables.create()
        })
    }
    
    func save() -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            do {
                try self.context.save()
                observer(CompletableEvent.completed)
            } catch {
                observer(CompletableEvent.error(error))
            }
            return Disposables.create()
        })
    }
    
    func saveSync() throws {
        try context.save()
    }
    
    func createEntity() -> SessionEntity {
        return NSEntityDescription.insertNewObject(forEntityName: "SessionEntity", into: context) as! SessionEntity
        
    }
    
    
}
