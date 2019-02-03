//
//  ConsumptionDAO.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 03..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol ConsumptionDAO : DAO {
    func get(_ consumptionId: String) -> Maybe<ConsumptionEntity>
    
    func getAll(sessionId: String) -> Maybe<[ConsumptionEntity]>
    
    func delete(consumptions: ConsumptionEntity ...) -> Completable
    
    func deleteAll(sessionId: String) -> Completable
    
    func createEntity() -> ConsumptionEntity
}
