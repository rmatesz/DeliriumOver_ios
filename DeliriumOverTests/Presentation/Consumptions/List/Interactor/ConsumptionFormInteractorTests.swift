//
//  ConsumptionFormInteractorTests.swift
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

class ConsumptionFormInteractorTests: XCTestCase {
    private let sessionId = "TEST SESSION"
    private let drinks = [Drink(name: "Beer", alcohol: 0.053, defaultQuantity: 5.0, defaultUnit: .deciliter, drinkType: DrinkType.BEER, localization: ["Beer":"Beer"])]
    private lazy var session = Session(id: sessionId, inProgress: true)

    private let sessionRepository = MockSessionRepository()
    private let consumptionRepository = MockConsumptionRepository()
    private let drinkRepository = MockDrinkRepository()
    private lazy var underTest = ConsumptionFormInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository)

    //    func loadDrinks() -> Single<[Drink]>
    func testLoadDrinksEmitsDrinksLoadedFromRepo() throws {
        // GIVEN
        stub(drinkRepository) { mock in
            when(mock.getDrinks()).thenReturn(Single.just(drinks))
        }

        // WHEN
        let result = try underTest.loadDrinks().toBlocking().single()

        // THEN
        XCTAssertEqual(drinks, result)
    }

    func testLoadDrinksEmitsErrorFromRepo() throws {
        // GIVEN
        let error = "ERROR"
        stub(drinkRepository) { mock in
            when(mock.getDrinks()).thenReturn(Single.error(error))
        }

        // WHEN
        do {
            _ = try underTest.loadDrinks().toBlocking().single()

            // THEN
            assertionFailure("Error should be thrown")
        } catch let e {
            // THEN
            XCTAssertEqual(error, e as! String)
        }
    }

    //    func saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit) -> Completable
//    fun saveConsumption() {
    func testSaveConsumptionWhenSuccess() throws {
        // GIVEN
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.just(session))
        }
        stub(consumptionRepository) { mock in
            when(mock.saveConsumption(sessionId: sessionId, consumption: any())).thenReturn(Completable.empty())
        }
        let now = createDate(2020, 9, 26, 10, 10)
        dateProvider = TestDateProvider(date: now)

        // WHEN
        _ = try underTest.saveConsumption(drink: "Beer", alcohol: 0.053, quantity: 5.1, unit: .deciliter).toBlocking().toArray()

        // THEN
        let consumption = Consumption(drink: "Beer", quantity: 5.1, unit: .deciliter, alcohol: 0.053, date: now)
        verify(consumptionRepository).saveConsumption(sessionId: sessionId, consumption: consumption)
    }

    func testSaveConsumptionWhenSuccess2() throws {
        // GIVEN
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.just(session))
        }
        stub(consumptionRepository) { mock in
            when(mock.saveConsumption(sessionId: sessionId, consumption: any())).thenReturn(Completable.empty())
        }
        let date = createDate(2020, 9, 29, 12, 10)

        // WHEN
        _ = try underTest.saveConsumption(drink: "Beer", alcohol: 0.053, quantity: 5.1, unit: .deciliter, date: date).toBlocking().toArray()

        // THEN
        let consumption = Consumption(drink: "Beer", quantity: 5.1, unit: .deciliter, alcohol: 0.053, date: date)
        verify(consumptionRepository).saveConsumption(sessionId: sessionId, consumption: consumption)
    }

    func testSaveConsumptionWhenNoSessionInProgress() {
        // GIVEN
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.empty())
        }

        // WHEN
        do {
            _ = try underTest.saveConsumption(drink: "Beer", alcohol: 0.053, quantity: 5.1, unit: .deciliter).toBlocking().toArray()
            assertionFailure("Error should be thrown!")
        } catch {
            assert(error is RepositoryError)
        }
    }


    func testSaveConsumptionSessionInProgressDoesNOTEmit() {
        // GIVEN
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.never())
        }

        // WHEN
        do {
            _ = try underTest.saveConsumption(drink: "Beer", alcohol: 0.053, quantity: 5.1, unit: .deciliter).toBlocking().toArray()
            assertionFailure("Error should be thrown!")
        } catch {
            assert(error is RepositoryError)
        }
    }

    func testSaveConsumptionSessionWhenSaveError() {
        // GIVEN
        let error = "ERROR"
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.just(session))
        }
        stub(consumptionRepository) { mock in
            when(mock.saveConsumption(sessionId: sessionId, consumption: any())).thenReturn(Completable.error(error))
        }

        // WHEN
        do {
            _ = try underTest.saveConsumption(drink: "Beer", alcohol: 0.053, quantity: 5.1, unit: .deciliter).toBlocking().toArray()
            assertionFailure("Error should be thrown!")
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

    //    func validateDrink(drink: String) -> ConsumptionFormValidationResult
    func testValidateDrink() {
        // GIVEN
        let params = [
            "": ConsumptionFormValidationResult.EMPTY,
            "a": ConsumptionFormValidationResult.SUCCESS
        ]

        params.forEach { (drink, expected) in
            // WHEN
            let actual = underTest.validateDrink(drink: drink)

            // THEN
            XCTAssertEqual(expected, actual)

        }
    }
    //    func validateAlcohol(alcohol: Double?) -> ConsumptionFormValidationResult
    func testValidateAlcohol() {
        // GIVEN
        let params = [
            nil: ConsumptionFormValidationResult.EMPTY,
            -1: ConsumptionFormValidationResult.NEGATIVE,
            0: ConsumptionFormValidationResult.ZERO,
            0.0001: ConsumptionFormValidationResult.SUCCESS
        ]

        params.forEach { (alcohol, expected) in
            // WHEN
            let actual = underTest.validateAlcohol(alcohol: alcohol)

            // THEN
            XCTAssertEqual(expected, actual)

        }
    }
    //    func validateQuantity(quantity: Double?) -> ConsumptionFormValidationResult
    func testValidateQuantity() {
        // GIVEN
        let params = [
            nil: ConsumptionFormValidationResult.EMPTY,
            -1: ConsumptionFormValidationResult.NEGATIVE,
            0: ConsumptionFormValidationResult.ZERO,
            0.0001: ConsumptionFormValidationResult.SUCCESS
        ]

        params.forEach { (quantity, expected) in
            // WHEN
            let actual = underTest.validateQuantity(quantity: quantity)

            // THEN
            XCTAssertEqual(expected, actual)

        }
    }

    //    func resolveDate(currentDate: Date, newDate: Date) -> Date
    func testResolveDate() {
        // GIVEN
        let params = [
            ("#1", createDate(2020, 9, 28, 16, 1), createDate(2020, 9, 28, 20, 2), createDate(2020, 9, 27, 20, 2)),
            ("#2", createDate(2020, 9, 28, 0, 1), createDate(2020, 9, 28, 23, 59), createDate(2020, 9, 27, 23, 59)),
            ("#3", createDate(2020, 9, 28, 0, 1), createDate(2020, 9, 28, 4, 2), createDate(2020, 9, 27, 4, 2)),
            ("#4", createDate(2020, 9, 28, 23, 59), createDate(2020, 9, 28, 2, 30), createDate(2020, 9, 29, 2, 30)),
            ("#5", createDate(2020, 9, 28, 20, 2), createDate(2020, 9, 28, 0, 1), createDate(2020, 9, 29, 0, 1)),

            ("#6", createDate(2020, 9, 28, 16, 2), createDate(2020, 9, 28, 20, 1), createDate(2020, 9, 28, 20, 1)),
            ("#7", createDate(2020, 9, 28, 0, 20), createDate(2020, 9, 28, 3, 20), createDate(2020, 9, 28, 3, 20)),
            ("#8", createDate(2020, 9, 28, 8, 1), createDate(2020, 9, 28, 0, 0), createDate(2020, 9, 28, 0, 0)),
            ("#9", createDate(2020, 9, 28, 19, 59), createDate(2020, 9, 28, 1, 20), createDate(2020, 9, 28, 1, 20)),
            ("#10", createDate(2020, 9, 28, 20, 1), createDate(2020, 9, 28, 1, 20), createDate(2020, 9, 28, 1, 20)),
            ("#11", createDate(2019, 1, 24, 9, 24), createDate(2019, 1, 24, 13, 23), createDate(2019, 1, 24, 13, 23)),
            ("#12", createDate(2019, 1, 24, 9, 24), createDate(2019, 1, 24, 20, 23), createDate(2019, 1, 23, 20, 23)),
            ("#13", createDate(2019, 1, 24, 23, 24), createDate(2019, 1, 24, 3, 0), createDate(2019, 1, 25, 3, 0)),
            ("#14", createDate(2019, 1, 24, 23, 24), createDate(2019, 1, 24, 23, 30), createDate(2019, 1, 24, 23, 30)),
            ("#15", createDate(2019, 1, 24, 23, 24), createDate(2019, 1, 24, 20, 30), createDate(2019, 1, 24, 20, 30)),
            ("#16", createDate(2019, 1, 24, 0, 24), createDate(2019, 1, 24, 20, 30), createDate(2019, 1, 23, 20, 30))

        ]

        // WHEN
        params.forEach { (testCase, now, param, expected) in
            let actual = underTest.resolveDate(currentDate: now, newDate: param)
            XCTAssertEqual(expected, actual, "Test case \"\(testCase)\" failed!")
        }
    }
}
