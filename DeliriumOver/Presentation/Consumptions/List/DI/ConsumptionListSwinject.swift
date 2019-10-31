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
            container.register(ConsumptionListView.self, factory: { (resolver) -> ConsumptionListView in
                controller
            })
            container.register(UIViewController.self, factory: { (resolver) -> UIViewController in
                controller
            })
            container.register(UIStoryboard.self, factory: { (resolver) -> UIStoryboard in
                controller.storyboard!
            })
            controller.presenter = resolver.resolve(ConsumptionListPresenter.self)
        }
        
        container.register(ConsumptionListPresenter.self) { (resolver) -> ConsumptionListPresenter in
            ConsumptionListPresenter(view: resolver.resolve(ConsumptionListView.self)!, interactor: resolver.resolve(ConsumptionListInteractor.self)!, router: resolver.resolve(ConsumptionListRouter.self)!)
        }
        
        container.register(ConsumptionListRouter.self) { (resolver) -> ConsumptionListRouter in
            ConsumptionListRouter(resolver.resolve(UIViewController.self)!, resolver.resolve(UIStoryboard.self)!)
        }

        container.register(ConsumptionListInteractor.self) { (resolver) -> ConsumptionListInteractor in
            ConsumptionListInteractorImpl(sessionRepository: resolver.resolve(SessionRepository.self)!, consumptionRepository: resolver.resolve(ConsumptionRepository.self)!, drinkRepository: resolver.resolve(DrinkRepository.self)!)
        }
    }
}
