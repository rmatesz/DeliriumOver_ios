//
//  ConsumptionListPresenter.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ConsumptionListPresenter: BasePresenter {
    private let view: ConsumptionListView
    private let interactor: ConsumptionListInteractor
    private let router: ConsumptionListRouter
    private var drinks = [Drink]()
    private var consumptions = [Consumption]()
    
    init(view: ConsumptionListView, interactor: ConsumptionListInteractor, router: ConsumptionListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    func start() {
        interactor.loadConsumptions()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .do(onNext: { self.consumptions = $0 })
            .subscribe(onNext: { (consumptions) in
                self.view.displayConsumptionList(
                    consumptions: consumptions.map({ (consumption) -> ConsumptionListItem in
                        ConsumptionListItem(drink: consumption.drink, alcohol: "\(consumption.alcohol*100)%", quantity: "\(consumption.quantity)  \(consumption.unit)", date: consumption.date)
                    }))
            }, onError: { (error) in
                print(error)
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
    
    public func refresh() {
        interactor.refresh()
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

    public func onConsumptionSwiped(index: Int) {
        interactor.delete(consumption: consumptions[index])
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onCompleted: {
                
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func addNewConsumption() {
        router.openConsumptionForm()
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
