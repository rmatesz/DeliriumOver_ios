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
    
    
    func delete(consumptions: Consumption ...) -> Completable
    
    func insert(sessionId: String, consumption: Consumption) -> Completable
}
