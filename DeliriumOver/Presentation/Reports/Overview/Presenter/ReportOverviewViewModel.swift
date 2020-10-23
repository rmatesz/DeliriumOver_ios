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

protocol ReportOverviewViewModel: AddConsumptionViewModel {
    var bacLevel: BehaviorRelay<Float> { get }
    var alcoholEliminationDate: BehaviorRelay<Date> { get }
    var sessionTitle: BehaviorRelay<String> { get }
    var chartData: BehaviorRelay<[Record]> { get }
    var drinks: Observable<[Drink]> { get }
    var onboardingTrigger: BehaviorRelay<[OnboardingManager.Onboarding]> { get }

    func onTitleEdited(title: String)

    func addDrinkAsConsumption(drink: Drink) -> Completable

    func setOnboardingDone(_ onboarding: OnboardingManager.Onboarding)
}
