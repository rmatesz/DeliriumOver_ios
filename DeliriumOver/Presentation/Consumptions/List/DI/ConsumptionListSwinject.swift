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
            controller.presenter = resolver.resolve(ConsumptionListPresenter.self)
        }
        
        container.register(ConsumptionListPresenter.self) { (resolver) -> ConsumptionListPresenter in
            ConsumptionListPresenter(view: resolver.resolve(ConsumptionListView.self)!, interactor: resolver.resolve(ConsumptionListInteractor.self)!, router: resolver.resolve(ConsumptionListRouter.self)!)
        }
        
        container.register(ConsumptionListRouter.self) { (resolver) -> ConsumptionListRouter in
            ConsumptionListRouter()
        }

        container.register(ConsumptionListInteractor.self) { (resolver) -> ConsumptionListInteractor in
            ConsumptionListInteractor(sessionRepository: resolver.resolve(SessionRepository.self)!, consumptionRepository: resolver.resolve(ConsumptionRepository.self)!)
        }
    }
}
