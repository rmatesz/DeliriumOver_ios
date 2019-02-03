//
//  ConsumptionRepositoryImpl.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 03..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ConsumptionRepositoryImpl : ConsumptionRepository {
    private let consumptionDAO: ConsumptionDAO
    private let sessionDAO: SessionDAO
    
    init(consumptionDAO: ConsumptionDAO, sessionDAO: SessionDAO) {
        self.sessionDAO = sessionDAO
        self.consumptionDAO = consumptionDAO
    }

    func delete(consumption: Consumption) -> Completable {
        return consumptionDAO.get(consumption.id)
            .ifEmpty(switchTo: Single.error(RepositoryError(message: "Object Not found in DB")))
            .flatMapCompletable { (consumptionEntity) -> Completable in
                self.consumptionDAO.delete(consumptions: consumptionEntity)
            }
    }
    
    func saveConsumption(sessionId: String, consumption: Consumption) -> Completable {
        return sessionDAO.get(sessionId).ifEmpty(switchTo: Single.error(RepositoryError(message: "session not found in DB")))
            .flatMapCompletable { (session) -> Completable in
                let consumptionEntity = self.consumptionDAO.createEntity()
                consumptionEntity.session = session
                consumptionEntity.alcohol = consumption.alcohol
                consumptionEntity.date = consumption.date
                consumptionEntity.drink = consumption.drink
                consumptionEntity.quantity = consumption.quantity
                consumptionEntity.unit = Int16(consumption.unit.rawValue)
                return self.consumptionDAO.save()
            }
    }
}
