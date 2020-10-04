//
//  ConsumptionFormPresenterImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ConsumptionFormPresenterImpl : BasePresenter, ConsumptionFormPresenter {
    
    private final var view: ConsumptionFormView
    private let interactor: ConsumptionFormInteractor
    private let router: ConsumptionFormRouter

    private var drink: String? = nil {
        didSet {
            validate(drink: drink!)
            view.saveIsEnabled = mandatoryFieldsFilled && !hasError
        }
    }
    private var alcohol: Double? = nil {
        didSet {
            view.saveIsEnabled = mandatoryFieldsFilled && !hasError
        }
    }
    private var quantity: Double? = nil {
        didSet {
            view.saveIsEnabled = mandatoryFieldsFilled && !hasError
        }
    }
    private var drinkUnit: DrinkUnit? = nil
    private var time: Date? {
        didSet {
            if (time != nil) {
                view.updateTime(time!)
            }
        }
    }
    private var drinkError = false
    private var alcoholError = false
    private var quantityError = false
    private var hasError: Bool {
        return drinkError || alcoholError || quantityError
    }
    private var mandatoryFieldsFilled: Bool {
        return drink != "" && quantity != nil && alcohol != nil
    }

    init(router: ConsumptionFormRouter, view: ConsumptionFormView, interactor: ConsumptionFormInteractor) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func loadData() {
        time = dateProvider.currentDate
        view.saveIsEnabled = mandatoryFieldsFilled && !hasError
    }

    func onSaveClicked() {
        guard let drink = drink, let alcohol = alcohol, let quantity = quantity, let drinkUnit = drinkUnit else {
            return
        }

        interactor.saveConsumption(drink: drink,
                                   alcohol: alcohol / 100.0,
                                   quantity: quantity,
                                   unit: drinkUnit,
                                   date: time ?? currentDate)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onCompleted: {
                self.router.finish()
            }, onError: {
                Logger.w(tag: "ConsumptionForm",
                         category: "Consumption registry",
                         message: "Error during saving consumption.",
                         error: $0)
            })
            .disposed(by: disposeBag)
    }

    // MARK: field changes from UI
    func onDrinkChanged(_ value: String) {
        drink = value
    }

    func onAlcoholChanged(_ value: Double) {
        alcohol = value
    }

    func onQuantityChanged(_ value: Double) {
        quantity = value
    }

    func onDrinkUnitChanged(_ value: DrinkUnit) {
        drinkUnit = value
    }

    func onTimeChanged(_ value: Date) {
        time = interactor.resolveDate(currentDate: currentDate, newDate: value)
    }

    // MARK: Validating fields
    private func validate(drink: String) {
        switch (interactor.validateDrink(drink: drink)) {
        case .SUCCESS:
            view.hideDrinkError()
        case .EMPTY:
            view.showDrinkError("Mandatory to fill")
        default:
            view.showDrinkError("Unknown error")
        }
    }
}
