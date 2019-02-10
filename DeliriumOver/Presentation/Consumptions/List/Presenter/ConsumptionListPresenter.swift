//
//  ConsumptionListPresenter.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ConsumptionListPresenter {
    private let view: ConsumptionListView
    private let interactor: ConsumptionListInteractor
    private let router: ConsumptionListRouter
    
    init(view: ConsumptionListView, interactor: ConsumptionListInteractor, router: ConsumptionListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func start() {
        interactor.loadSession()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe { (event) in
                switch event {
                    case .success(let consumptions):
                        self.view.displayConsumptionList(
                            consumptions: consumptions.map({ (consumption) -> ConsumptionListItem in
                            ConsumptionListItem(drink: consumption.drink, alcohol: "\(consumption.alcohol*100)%)", quantity: "\(consumption.quantity)  \(consumption.unit)", date: consumption.date)
                    }))
                case .error(let error): print("error")
                case .completed: print("completed")
                }
            }
    }
}
