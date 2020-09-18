//
//  SessionManagersSwinject.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 20..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class SessionManagersSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.register(AutoSessionOpenerImpl.self) { (resolver) -> AutoSessionOpenerImpl in
            AutoSessionOpenerImpl(sessionRepository: resolver.resolve(SessionRepository.self)!)
        }

        defaultContainer.register(AutoSessionCloserImpl.self) { (resolver) -> AutoSessionCloserImpl in
            AutoSessionCloserImpl(sessionRepository: resolver.resolve(SessionRepository.self)!, alcoholCalculator: resolver.resolve(AlcoholCalculatorRxDecorator.self)!)
        }
    }
}
