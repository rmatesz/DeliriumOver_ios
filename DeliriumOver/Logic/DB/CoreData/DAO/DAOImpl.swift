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
    let coreDataAdapter: CoreDataAdapter
    
    init (context: NSManagedObjectContext, coreDataAdapter: CoreDataAdapter) {
        self.context = context
        self.coreDataAdapter = coreDataAdapter
    }

    func getEntity<T>(id: String) -> Maybe<T> {
        return Maybe<T>.from {
            guard let url = URL(string: id) else {
                throw DatabaseError(message: "Invalid objectID: \(id)")
            }
            guard let objectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url) else {
                return nil
            }
            let result = try self.context.existingObject(with: objectId)
            guard let entity = result as? T else {
                throw DatabaseError(message: "The id(\(id) doesn't represent the expected entity \(T.Type.self). The returned object is: \(result)")
            }
            return entity
        }
    }

    func save() -> Completable {
        return Completable.from {
            try self.context.save()
        }
    }

    internal func finaliseEntity<T: NSManagedObject>(entity: T, fillEntity: @escaping (T) -> Void) -> Single<T> {
        return Single<T>.create { (observer) -> Disposable in
            DispatchQueue.main.async {
                fillEntity(entity)
                do {
                    try self.context.obtainPermanentIDs(for: [entity])
                    try self.context.save()
                    observer(SingleEvent.success(entity))
                } catch {
                    observer(SingleEvent.error(error))
                }
            }
            return Disposables.create()
        }

    }
}
