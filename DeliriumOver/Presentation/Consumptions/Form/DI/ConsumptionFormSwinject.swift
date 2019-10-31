//
//  ConsumptionFormSwinject.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 05..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class ConsumptionFormSwinject {
    class func setup(_ container: Container) {
        container.storyboardInitCompleted(ConsumptionFormViewController.self) { (resolver, controller) in
            container.register(ConsumptionFormView.self, factory: { (resolver) -> ConsumptionFormView in
                controller
            })
            container.register(UIViewController.self, factory: { (resolver) -> UIViewController in
                controller
            })
            container.register(UIStoryboard.self, factory: { (resolver) -> UIStoryboard in
                controller.storyboard!
            })
            controller.presenter = resolver.resolve(ConsumptionFormPresenter.self)
        }
        
        container.register(ConsumptionFormPresenter.self) { (resolver) -> ConsumptionFormPresenter in
            ConsumptionFormPresenterImpl(router: resolver.resolve(ConsumptionFormRouter.self)!, view: resolver.resolve(ConsumptionFormView.self)!, interactor: resolver.resolve(ConsumptionFormInteractor.self)!)
        }

        container.register(UINavigationController.self) { (resolver) -> UINavigationController in
            resolver.resolve(UIViewController.self)!.navigationController!
        }
        
        container.register(ConsumptionFormRouter.self) { (resolver) -> ConsumptionFormRouter in
            ConsumptionFormRouterImpl(navigationController: resolver.resolve(Lazy<UINavigationController>.self)!)
        }
        
        container.register(ConsumptionFormInteractor.self) { (resolver) -> ConsumptionFormInteractor in
            ConsumptionFormInteractorImpl(sessionRepository: resolver.resolve(SessionRepository.self)!, consumptionRepository: resolver.resolve(ConsumptionRepository.self)!, drinkRepository: resolver.resolve(DrinkRepository.self)!)
        }
    }
}
