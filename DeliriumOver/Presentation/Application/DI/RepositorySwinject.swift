//
//  RepositorySwinject.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class RepositorySwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.register(SessionRepository.self) { (resolver) -> SessionRepository in
            SessionRepositoryImpl(sessionDAO: resolver.resolve(SessionDAO.self)!, firebaseCommunicator: resolver.resolve(FirebaseCommunicator.self)!, deviceId: "DEVICE_ID")
        }
        
        defaultContainer.register(ConsumptionRepository.self) { (resolver) -> ConsumptionRepository in
            ConsumptionRepositoryImpl(consumptionDAO: resolver.resolve(ConsumptionDAO.self)!, sessionDAO: resolver.resolve(SessionDAO.self)!)
        }
    }
}
