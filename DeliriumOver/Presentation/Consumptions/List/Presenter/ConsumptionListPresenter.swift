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
    private let disposeBag = DisposeBag()
    private var drinks = [Drink]()
    
    init(view: ConsumptionListView, interactor: ConsumptionListInteractor, router: ConsumptionListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    func start() {
        interactor.loadConsumptions()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onNext: { (consumptions) in
                self.view.displayConsumptionList(
                    consumptions: consumptions.map({ (consumption) -> ConsumptionListItem in
                        ConsumptionListItem(drink: consumption.drink, alcohol: "\(consumption.alcohol*100)%)", quantity: "\(consumption.quantity)  \(consumption.unit)", date: consumption.date)
                    }))
            }, onError: { (_) in
                print("error")
            })
            .disposed(by: disposeBag)
        
        interactor.loadFrequentlyConsumedDrinks()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onNext: { (drinks) in
                var menuItems = drinks.map({ (drink) -> MenuItem in
                    MenuItem(title: drink.name, entity: drink)
                })
                menuItems.append(MenuItem(title: "Add new...", entity: nil))
                self.view.updateAddMenuItems(menuItems: menuItems)
            }, onError: { (error) in
                print("error")
            })
            .disposed(by: disposeBag)
    }

    public func onAddClicked() {
        addNewConsumption()
    }

    public func onMenuItemSelected(menuItem: MenuItem) {
        let drink = menuItem.entity as? Drink
        if drink == nil {
            addNewConsumption()
        } else {
            addDrinkAsConsumption(drink: drink!)
        }
    }
    
    private func addNewConsumption() {
        // router.openAddConsumption()
    }
    
    private func addDrinkAsConsumption(drink: Drink) {
        // router.showLoading
        interactor.add(drink: drink)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onCompleted: {
                // router.hideLoading
            }, onError: { (error) in
                print("")
            })
            .disposed(by: disposeBag)
    }
}
