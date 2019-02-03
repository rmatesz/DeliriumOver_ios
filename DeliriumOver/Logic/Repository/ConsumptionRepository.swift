//
//  ConsumptionRepository.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 03..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol ConsumptionRepository {
    func delete(consumption: Consumption) -> Completable
    func saveConsumption(sessionId: String, consumption: Consumption) -> Completable
}
