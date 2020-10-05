//
//  OnboardingSwinject.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 05..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class OnboardingSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.register(OnboardingManager.self) { (resolver) -> OnboardingManager in
            OnboardingManager(userDefaults: UserDefaults.standard)
        }
    }
}
