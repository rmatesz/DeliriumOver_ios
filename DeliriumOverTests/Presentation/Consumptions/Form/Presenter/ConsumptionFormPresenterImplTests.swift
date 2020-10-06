//
//  ConsumptionFormPresenterTests.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 09. 28..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import Cuckoo
import RxSwift
import XCTest
@testable import DeliriumOver

class ConsumptionFormPresenterTests: XCTestCase {
    private let drink = "TEST DRINK"
    private let alcohol = 3.0
    private let quantity = 3.33
    private let date = createDate(2020, 10, 11, 11, 30)
    private let now = createDate(2020, 10, 10, 10, 30)
    private let router = MockConsumptionFormRouter()
    private let view = MockConsumptionFormView()
    private let interactor = MockConsumptionFormInteractor()
    private lazy var underTest = ConsumptionFormPresenterImpl(router: router, view: view, interactor: interactor)

    override func setUp() {
        dateProvider = TestDateProvider(date: now)

        stub(router) { mock in
            mock.finish().thenDoNothing()
        }

        stub(view) { mock in
            mock.hideDrinkError().thenDoNothing()
            mock.showDrinkError(any()).thenDoNothing()
            mock.saveIsEnabled.set(any()).thenDoNothing()
            mock.updateTime(any()).thenDoNothing()
        }
    }

    func testLoadData() {
        underTest.loadData()

        verify(view).updateTime(now)
    }

    func testOnTimeChanged() {
        let resolvedDate = createDate(2020, 10, 12, 12, 30)
        stub(interactor) { mock in
            when(mock.resolveDate(currentDate: now, newDate: date)).thenReturn(resolvedDate)
        }

        underTest.onTimeChanged(date)

        verify(view).updateTime(resolvedDate)
    }

    func testOnDrinkChangedToFilled() {
        stub(interactor) { mock in
            when(mock.validateDrink(drink: drink)).thenReturn(ConsumptionFormValidationResult.SUCCESS)
        }

        underTest.onDrinkChanged(drink)

        verify(view).hideDrinkError()
    }

    func testOnDrinkChangedToEmpty() {
        stub(interactor) { mock in
            when(mock.validateDrink(drink: drink)).thenReturn(ConsumptionFormValidationResult.EMPTY)
        }

        underTest.onDrinkChanged(drink)

        verify(view).showDrinkError("Mandatory to fill")
    }

    func testOnDrinkChangedAndUnknownErrorHappened() {
        stub(interactor) { mock in
            when(mock.validateDrink(drink: drink)).thenReturn(ConsumptionFormValidationResult.ZERO)
        }

        underTest.onDrinkChanged(drink)

        verify(view).showDrinkError("Unknown error")
    }

    func testOnAlcoholChangedToValid() {
        stub(interactor) { mock in
            when(mock.validateAlcohol(alcohol: alcohol)).thenReturn(ConsumptionFormValidationResult.SUCCESS)
        }

        underTest.onAlcoholChanged(alcohol)
    }

    func testOnAlcoholChangedToNegative() {
        stub(interactor) { mock in
            when(mock.validateAlcohol(alcohol: alcohol)).thenReturn(ConsumptionFormValidationResult.NEGATIVE)
        }
        underTest.onAlcoholChanged(alcohol)
    }

    func testOnAlcoholChangedToZero() {
        stub(interactor) { mock in
            when(mock.validateAlcohol(alcohol: alcohol)).thenReturn(ConsumptionFormValidationResult.ZERO)
        }

        underTest.onAlcoholChanged(alcohol)
    }


    func testOnAlcoholChangedToEmpty() {
        stub(interactor) { mock in
            when(mock.validateAlcohol(alcohol: alcohol)).thenReturn(ConsumptionFormValidationResult.EMPTY)
        }

        underTest.onAlcoholChanged(alcohol)
    }

    func testOnQuantityChangedToValid() {
        stub(interactor) { mock in
            when(mock.validateQuantity(quantity: quantity)).thenReturn(ConsumptionFormValidationResult.SUCCESS)
        }

        underTest.onQuantityChanged(quantity)
    }

    func testOnQuantityChangedToNegative() {
        stub(interactor) { mock in
            when(mock.validateQuantity(quantity: quantity)).thenReturn(ConsumptionFormValidationResult.NEGATIVE)
        }

        underTest.onQuantityChanged(quantity)
    }

    func testOnQuantityChangedToZero() {
        stub(interactor) { mock in
            when(mock.validateQuantity(quantity: quantity)).thenReturn(ConsumptionFormValidationResult.ZERO)
        }
        underTest.onQuantityChanged(quantity)
    }

    func testOnQuantityChangedToEmpty() {
        stub(interactor) { mock in
            when(mock.validateQuantity(quantity: quantity)).thenReturn(ConsumptionFormValidationResult.EMPTY)
        }
        underTest.onQuantityChanged(quantity)
    }

    func testOnDrinkUnitChanged() {
        underTest.onDrinkUnitChanged(DrinkUnit.deciliter)
    }

    func testOnSaveClickedWhenEverythingSet() {
        // GIVEN
        stub(interactor) { mock in
            mock.validateDrink(drink: drink).thenReturn(.SUCCESS)
            mock.resolveDate(currentDate: now, newDate: date).thenReturn(date)
            mock.saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any()).thenReturn(Completable.empty())
        }

        underTest.onDrinkChanged(drink)
        underTest.onAlcoholChanged(alcohol)
        underTest.onQuantityChanged(quantity)
        underTest.onDrinkUnitChanged(.deciliter)
        underTest.onTimeChanged(date)

        // WHEN
        underTest.onSaveClicked()

        // THEN
        verify(interactor).saveConsumption(drink: drink, alcohol: alcohol / 100, quantity: quantity, unit: DrinkUnit.deciliter, date: date)
    }

    func testOnSaveClickedWhenDrinkNotSet() {
        // GIVEN
        stub(interactor) { mock in
            mock.validateDrink(drink: drink).thenReturn(.SUCCESS)
            mock.resolveDate(currentDate: now, newDate: date).thenReturn(date)
            mock.saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any()).thenReturn(Completable.empty())
        }

        underTest.onAlcoholChanged(alcohol)
        underTest.onQuantityChanged(quantity)
        underTest.onDrinkUnitChanged(.deciliter)
        underTest.onTimeChanged(date)

        // WHEN
        underTest.onSaveClicked()

        // THEN
        verify(interactor, never()).saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any())
        verify(interactor, never()).saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any())
    }

    func testOnSaveClickedWhenDateNotSet() {
        // GIVEN
        stub(interactor) { mock in
            mock.validateDrink(drink: drink).thenReturn(.SUCCESS)
            mock.saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any()).thenReturn(Completable.empty())
        }

        underTest.onDrinkChanged(drink)
        underTest.onAlcoholChanged(alcohol)
        underTest.onQuantityChanged(quantity)
        underTest.onDrinkUnitChanged(.deciliter)

        // WHEN
        underTest.onSaveClicked()

        // THEN
        verify(interactor).saveConsumption(drink: drink, alcohol: alcohol / 100, quantity: quantity, unit: DrinkUnit.deciliter, date: now)
    }


    func testOnSaveClickedWhenAlcoholNotSet() {
        // GIVEN
        stub(interactor) { mock in
            mock.validateDrink(drink: drink).thenReturn(.SUCCESS)
            mock.resolveDate(currentDate: now, newDate: date).thenReturn(date)
            mock.saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any()).thenReturn(Completable.empty())
        }

        underTest.onDrinkChanged(drink)
        underTest.onQuantityChanged(quantity)
        underTest.onDrinkUnitChanged(.deciliter)

        // WHEN
        underTest.onSaveClicked()

        // THEN
        verify(interactor, never()).saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any())
        verify(interactor, never()).saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any())
    }

    func testOnSaveClickedWhenQuantityNotSet() {
        // GIVEN
        stub(interactor) { mock in
            mock.validateDrink(drink: drink).thenReturn(.SUCCESS)
            mock.resolveDate(currentDate: now, newDate: date).thenReturn(date)
            mock.saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any()).thenReturn(Completable.empty())
        }

        underTest.onDrinkChanged(drink)
        underTest.onAlcoholChanged(alcohol)
        underTest.onDrinkUnitChanged(.deciliter)
        underTest.onTimeChanged(date)

        // WHEN
        underTest.onSaveClicked()

        // THEN
        verify(interactor, never()).saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any())
        verify(interactor, never()).saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any())
    }

    func testOnSaveClickedWhenDrinkUnitNotSet() {
        // GIVEN
        stub(interactor) { mock in
            mock.validateDrink(drink: drink).thenReturn(.SUCCESS)
            mock.resolveDate(currentDate: now, newDate: date).thenReturn(date)
            mock.saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any()).thenReturn(Completable.empty())
        }

        underTest.onDrinkChanged(drink)
        underTest.onAlcoholChanged(alcohol)
        underTest.onQuantityChanged(quantity)
        underTest.onTimeChanged(date)

        // WHEN
        underTest.onSaveClicked()

        // THEN
        verify(interactor, never()).saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any(), date: any())
        verify(interactor, never()).saveConsumption(drink: any(), alcohol: any(), quantity: any(), unit: any())
    }
}

extension Date: Matchable {

}

extension DrinkUnit: Matchable {

}
