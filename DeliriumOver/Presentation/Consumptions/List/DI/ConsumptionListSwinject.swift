//
//  ConsumptionListSwinject.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class ConsumptionListSwinject {
    class func setup(_ container: Container) {
        container.storyboardInitCompleted(ConsumptionListViewController.self) { (resolver, controller) in
            container.register(UIViewController.self, factory: { (resolver) -> UIViewController in
                controller
            })
            container.register(UIStoryboard.self, factory: { (resolver) -> UIStoryboard in
                controller.storyboard!
            })
            controller.viewModel = resolver.resolve(ConsumptionListViewModel.self)
        }
        
        container.register(ConsumptionListViewModel.self) { (resolver) -> ConsumptionListViewModel in
            ConsumptionListViewModelImpl(interactor: resolver.resolve(ConsumptionListInteractor.self)!)
        }

        container.register(ConsumptionListInteractor.self) { (resolver) -> ConsumptionListInteractor in
            ConsumptionListInteractorImpl(sessionRepository: resolver.resolve(SessionRepository.self)!, consumptionRepository: resolver.resolve(ConsumptionRepository.self)!, drinkRepository: resolver.resolve(DrinkRepository.self)!)
        }
    }
}
