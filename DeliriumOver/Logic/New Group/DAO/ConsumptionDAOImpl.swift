//
//  ConsumptionDAOImpl.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 03..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class ConsumptionDAOImpl : DAOImpl, ConsumptionDAO {

    func get(_ consumptionId: String) -> Maybe<ConsumptionEntity> {
        return Maybe<ConsumptionEntity>.create { (observer: (MaybeEvent<ConsumptionEntity>) -> ()) -> Disposable in
            let objectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: URL(string: consumptionId)!)
            
            if (objectId == nil) {
                observer(.completed)
            } else {
                do {
                    let consumptionEntity = try self.context.existingObject(with: objectId!) as! ConsumptionEntity
                    observer(.success(consumptionEntity))
                } catch {
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func getAll(sessionId: String) -> Maybe<[ConsumptionEntity]> {
        return Maybe<[ConsumptionEntity]>.create { (observer: (MaybeEvent<[ConsumptionEntity]>) -> ()) -> Disposable in
            
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ConsumptionEntity")
                request.predicate = NSPredicate(format: "sessionId == %@", sessionId)
                request.returnsObjectsAsFaults = false
                
                let result = try self.context.fetch(request)
                let consumptions = result as! [ConsumptionEntity]
                observer(MaybeEvent.success(consumptions))
            } catch {
                observer(MaybeEvent.error(error))
            }
            return Disposables.create()
        }
    }
    
    func delete(consumptions: ConsumptionEntity...) -> Completable {
        return delete(consumptionEntities: consumptions)
    }

    private func delete(consumptionEntities: [ConsumptionEntity]) -> Completable {
        return Completable.create { (observer) -> Disposable in
            consumptionEntities.forEach { (consumption) in
                self.context.delete(consumption)
            }
            do {
                try self.context.save()
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }

    func deleteAll(sessionId: String) -> Completable {
        return getAll(sessionId: sessionId).ifEmpty(default: [])
            .flatMapCompletable({ (consumptions) -> Completable in
                self.delete(consumptionEntities: consumptions)
        })
    }

    func createEntity() -> ConsumptionEntity {
        return NSEntityDescription.insertNewObject(forEntityName: "ConsumptionEntity", into: super.context) as! ConsumptionEntity
    }
    
    
}
