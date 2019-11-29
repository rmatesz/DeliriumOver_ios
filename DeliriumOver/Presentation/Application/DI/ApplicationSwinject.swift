//
//  ApplicationSwinject.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        FirebaseSwinject.setup(defaultContainer: defaultContainer)
        CoreDataSwinject.setup(defaultContainer: defaultContainer)
        CalculationsSwinject.setup(defaultContainer: defaultContainer)
        RepositorySwinject.setup(defaultContainer: defaultContainer)
        ReportsOverviewSwinject.setup(defaultContainer: defaultContainer)
        ConsumptionListSwinject.setup(defaultContainer)
        ConsumptionFormSwinject.setup(defaultContainer)
    }
}

