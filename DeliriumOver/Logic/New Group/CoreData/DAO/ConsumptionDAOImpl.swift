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

    func get(_ consumptionId: String) -> Maybe<Consumption> {
        return Maybe<Consumption>.create { (observer: @escaping (MaybeEvent<Consumption>) -> ()) -> Disposable in
            DispatchQueue.main.async {
                let objectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: URL(string: consumptionId)!)

                if (objectId == nil) {
                    observer(.completed)
                } else {
                    do {
                        let consumptionEntity = try self.context.existingObject(with: objectId!) as! ConsumptionEntity
                        observer(.success(Consumption(consumptionEntity: consumptionEntity)))
                    } catch {
                        observer(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func getAll(sessionId: String) -> Maybe<[Consumption]> {
        return Maybe<[Consumption]>.create { (observer: @escaping (MaybeEvent<[Consumption]>) -> ()) -> Disposable in
            DispatchQueue.main.async {
                do {
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ConsumptionEntity")
                    request.predicate = NSPredicate(format: "sessionId == %@", sessionId)
                    request.returnsObjectsAsFaults = false

                    let result = try self.context.fetch(request)
                    let consumptions = result as! [ConsumptionEntity]
                    observer(MaybeEvent.success(consumptions.map { Consumption(consumptionEntity: $0) }))
                } catch {
                    observer(MaybeEvent.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func delete(consumptions: Consumption...) -> Completable {
        return Completable.concat(consumptions.map { consumption -> Completable in
            let getConsumption: Maybe<ConsumptionEntity> = getEntity(id: consumption.id)
            return getConsumption
                .ifEmpty(switchTo: Single.error(RepositoryError(message: "Can't find consumption in DB.")))
                .flatMapCompletable { self.delete(consumption: $0) }
        })
    }

    private func delete(consumption: ConsumptionEntity) -> Completable {
        return Completable.create { (observer) -> Disposable in
            DispatchQueue.main.async {
                self.context.delete(consumption)
                do {
                    try self.context.save()
                    observer(.completed)
                } catch {
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func insert(sessionId: String, consumption: Consumption) -> Completable {
        let getSession: Maybe<SessionEntity> = getEntity(id: sessionId)
        return getSession
            .ifEmpty(switchTo: Single.error(RepositoryError(message: "Can't find session in DB.")))
            .flatMapCompletable { session in
                DispatchQueue.main.async {
                    let consumptionEntity = self.createEntity()
                    consumptionEntity.session = session
                    consumptionEntity.alcohol = consumption.alcohol
                    consumptionEntity.date = consumption.date
                    consumptionEntity.drink = consumption.drink
                    consumptionEntity.quantity = consumption.quantity
                    consumptionEntity.unit = Int16(consumption.unit.multiplier())
                }
                return self.save()
        }
    }

    private func createEntity() -> ConsumptionEntity {
            return NSEntityDescription.insertNewObject(forEntityName: "ConsumptionEntity", into: super.context) as! ConsumptionEntity
    }
    
    
}
