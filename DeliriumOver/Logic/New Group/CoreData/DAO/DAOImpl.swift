//
//  DAOImpl.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 03..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class DAOImpl : DAO {
    let context: NSManagedObjectContext
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }

    func save() -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            DispatchQueue.main.async {
                do {
                    try self.context.save()
                    observer(CompletableEvent.completed)
                } catch {
                    observer(CompletableEvent.error(error))
                }
            }
            return Disposables.create()
        })
    }

    internal func getEntity<T>(id: String) -> Maybe<T> {
        return Maybe.create { (observer) -> Disposable in
            DispatchQueue.main.async {
                let objectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: URL(string: id)!)

                if (objectId == nil) {
                    observer(.completed)
                } else {
                    do {
                        if let result = try self.context.existingObject(with: objectId!) as? T {
                            observer(.success(result))
                        } else {
                            observer(.completed)
                        }
                    } catch {
                        observer(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
}
