//
//  NotificationsSwinject.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 16..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class NotificationsSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.register(NotificationScheduler.self) { (resolver) -> NotificationScheduler in
            NotificationScheduler(sessionRepository: resolver.resolve(SessionRepository.self)!, alcoholCalculator: resolver.resolve(AlcoholCalculatorRxDecorator.self)!)
        }
    }
}
