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
        return getEntity(id: consumptionId).map { Consumption(consumptionEntity: $0) }
    }

    func getAll(sessionId: String) -> Maybe<[Consumption]> {
        return Maybe<[Consumption]>.from {
            let request = NSFetchRequest<ConsumptionEntity>(entityName: "ConsumptionEntity")
            request.predicate = NSPredicate(format: "sessionId == %@", sessionId)
            request.returnsObjectsAsFaults = false

            let result = try self.context.fetch(request)
            return result.map { Consumption(consumptionEntity: $0) }
        }
    }

    func delete(consumptions: Consumption...) -> Completable {
        return Completable.concat(consumptions.map { consumption -> Completable in
            let getConsumption: Maybe<ConsumptionEntity> = getEntity(id: consumption.id)
            return getConsumption
                .ifEmpty(switchTo: Single.error(DatabaseError(message: "Can't find consumption in DB.")))
                .flatMapCompletable { self.delete(consumption: $0) }
        })
    }

    private func delete(consumption: ConsumptionEntity) -> Completable {
        return Completable.from {
            self.context.delete(consumption)
            try self.context.save()
        }
    }

    func insert(sessionId: String, consumption: Consumption) -> Completable {
        let getSession: Maybe<SessionEntity> = getEntity(id: sessionId)
        return getSession
            .ifEmpty(switchTo: Single.error(RepositoryError(message: "Can't find session in DB.")))
            .flatMap { session in
                self.coreDataAdapter.insertNewObject(forEntityName: "ConsumptionEntity", into: self.context)
                    .map { (session, $0 as! ConsumptionEntity) }
            }
            .flatMap { (session: SessionEntity, consumptionEntity: ConsumptionEntity) in
                self.finaliseEntity(entity: consumptionEntity, fillEntity: { consumptionEntity in
                    consumptionEntity.session = session
                    consumptionEntity.alcohol = consumption.alcohol
                    consumptionEntity.date = consumption.date
                    consumptionEntity.drink = consumption.drink
                    consumptionEntity.quantity = consumption.quantity
                    consumptionEntity.unit = Int16(consumption.unit.multiplier())
                })
            }.asCompletable()
    }
}
