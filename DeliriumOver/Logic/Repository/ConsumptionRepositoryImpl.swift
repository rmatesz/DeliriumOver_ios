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
        return consumptionDAO.delete(consumptions: consumption)
    }
    
    func saveConsumption(sessionId: String, consumption: Consumption) -> Completable {
        return self.consumptionDAO.insert(sessionId: sessionId, consumption: consumption)
    }
}
