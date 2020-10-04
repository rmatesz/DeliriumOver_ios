//
//  ConsumptionListPresenter.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ConsumptionListViewModel {
    var drinks: BehaviorRelay<[Drink]> { get }
    var consumptions: BehaviorRelay<[Consumption]> { get }

    func onConsumptionSwiped(index: Int)
    func addDrinkAsConsumption(drink: Drink) -> Completable
}

class ConsumptionListViewModelImpl: ConsumptionListViewModel {
    private let interactor: ConsumptionListInteractor
    let drinks = BehaviorRelay<[Drink]>(value: [])
    let consumptions = BehaviorRelay<[Consumption]>(value: [])
    private let disposeBag = DisposeBag()
    
    init(interactor: ConsumptionListInteractor) {
        self.interactor = interactor

        interactor.loadConsumptions()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .bind(to: consumptions)
            .disposed(by: disposeBag)
        
        interactor.loadFrequentlyConsumedDrinks()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .bind(to: drinks)
            .disposed(by: disposeBag)
    }

    public func onConsumptionSwiped(index: Int) {
        interactor.delete(consumption: consumptions.value[index])
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onCompleted: {
                
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    public func addDrinkAsConsumption(drink: Drink) -> Completable {
        return interactor.add(drink: drink)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
    }
}
