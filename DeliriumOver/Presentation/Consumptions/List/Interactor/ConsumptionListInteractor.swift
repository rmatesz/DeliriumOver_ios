//
//  ConsumptionListInteractor.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ConsumptionListInteractor {
    private let sessionRepository: SessionRepository
    private let consumptionRepository: ConsumptionRepository
    
    init(sessionRepository: SessionRepository, consumptionRepository: ConsumptionRepository) {
        self.sessionRepository = sessionRepository
        self.consumptionRepository = consumptionRepository
    }
    
    public func loadSession() -> Maybe<[Consumption]> {
        return sessionRepository.getInProgressSession()
            .map { (session) -> [Consumption] in
                session.consumptions
        }
    }
}
