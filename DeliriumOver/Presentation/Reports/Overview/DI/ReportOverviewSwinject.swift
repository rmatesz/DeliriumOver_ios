//
//  ReportOverviewSwinject.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class ReportsOverviewSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.storyboardInitCompleted(ReportsOverviewViewController.self) { (resolver, controller) in
            controller.viewModel = resolver.resolve(ReportOverviewViewModel.self)
        }
        
        defaultContainer.register(ReportOverviewViewModel.self) { (resolver) -> ReportOverviewViewModel in
            ReportOverviewViewModelImpl(interactor: resolver.resolve(ReportOverviewInteractor.self)!)
        }
        
        defaultContainer.register(ReportOverviewInteractor.self) { (resolver) -> ReportOverviewInteractor in
            ReportOverviewInteractorImpl(sessionRepository: resolver.resolve(SessionRepository.self)!, alcoholCalculator: resolver.resolve(AlcoholCalculatorRxDecorator.self)!)
        }
    }
}
