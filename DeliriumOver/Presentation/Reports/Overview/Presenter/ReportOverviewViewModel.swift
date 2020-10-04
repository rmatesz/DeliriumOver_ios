//
//  ReportOverviewPresenter.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ReportOverviewViewModel {
    var bacLevel: BehaviorRelay<Float> { get }
    var alcoholEliminationDate: BehaviorRelay<Date> { get }
    var sessionTitle: BehaviorRelay<String> { get }
    var chartData: BehaviorRelay<[Record]> { get }
    var drinks: BehaviorRelay<[Drink]> { get }

    func onTitleEdited(title: String)

    func addDrinkAsConsumption(drink: Drink) -> Completable
}
