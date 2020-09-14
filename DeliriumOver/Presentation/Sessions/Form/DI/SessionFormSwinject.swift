//
//  SessionFormSwinject.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 08. 26..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class SessionFormSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.storyboardInitCompleted(SessionFormViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(SessionFormViewModel.self)
        }
        
        defaultContainer.register(SessionFormViewModel.self) { (resolver) -> SessionFormViewModel in
            SessionFormViewModelImpl(sessionRepository: resolver.resolve(SessionRepository.self)!)
        }
    }
}
