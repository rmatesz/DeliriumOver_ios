//
//  ConsumptionListInteractor.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol ConsumptionListViewModel: AddConsumptionViewModel {
    var consumptions: Observable<[Consumption]> { get }
    var drinks: Observable<[Drink]> { get }
    func delete(consumption: Consumption) -> Completable
    func addDrinkAsConsumption(drink: Drink) -> Completable
}
