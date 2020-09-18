//
//  ConsumptionListInteractor.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol ConsumptionListInteractor {
    func loadConsumptions() -> Observable<[Consumption]>
    func loadFrequentlyConsumedDrinks() -> Observable<[Drink]>
    func delete(consumption: Consumption) -> Completable
    func add(drink: Drink) -> Completable
}
