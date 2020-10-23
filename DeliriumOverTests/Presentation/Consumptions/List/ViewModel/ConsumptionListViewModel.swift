//
//  ConsumptionListInteractorTest.swift
//  DeliriumOverTests
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import XCTest
import Cuckoo
import RxSwift
import RxBlocking
import RxTest
@testable import DeliriumOver

class ConsumptionListViewModelImplTest: XCTestCase {
    private static let testErrorMessage = "TEST ERROR"
    private static let testError: SimpleError = SimpleError.error(message: testErrorMessage)
    static let testConsumption1 = Consumption("1", drink: "test drink", quantity: 2.0, unit: DrinkUnit.deciliter, alcohol: 10.5)
    static let testConsumption2 = Consumption("2", drink: "test drink 2", quantity: 5.0, unit: DrinkUnit.centiliter, alcohol: 65.0)
    
    static let testSession = Session(
        id: "10",
        title: "Test session",
        description: "Test description",
        name: "Test Name",
        weight: 85.0,
        height: 175.0,
        gender: Sex.MALE,
        consumptions: [testConsumption1, testConsumption2],
        inProgress: false
    )
    var sessionRepository = MockSessionRepository()
    var consumptionRepository = MockConsumptionRepository()
    var drinkRepository = MockDrinkRepository()
    var underTest: ConsumptionListViewModelImpl?
    
    override func setUp() {
        super.setUp()
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository)
    }
    
    func testLoadConsumptionsWhenLoadSessionFailure() {
        stub(sessionRepository) { (stub) in
            when(stub.inProgressSession).get.thenReturn(Observable.error(ConsumptionListViewModelImplTest.testError))
        }

        do {
            _ = try underTest!.consumptions.toBlocking().first()
            XCTFail("Expected result is to throw error.")
        } catch {
            XCTAssertTrue(error is SimpleError)
            switch error as! SimpleError {
            case .error(let message):
                XCTAssertEqual(ConsumptionListViewModelImplTest.testErrorMessage, message)
            }
        }
    }

    func testLoadConsumptionsWhenNoSession() throws {
        stub(sessionRepository) { (stub) in
            when(stub.inProgressSession).get.thenReturn(Observable.empty())
        }
    
        do {
            _ = try underTest!.consumptions.toBlocking().first()
            XCTFail()
        } catch {
            if case SimpleError.error(let message) = error {
                XCTAssertEqual("Session can't be loaded!", message)
            } else {
                XCTFail("Invalid error type \(error)")
            }
        }
    }

    func testLoadConsumptionsWhenInProgressSession() throws {
        stub(sessionRepository) { (stub) in
            when(stub.inProgressSession).get.thenReturn(Observable.just(ConsumptionListViewModelImplTest.testSession))
        }
    
        let result = try underTest!.consumptions.toBlocking().first()
    
        XCTAssertEqual(ConsumptionListViewModelImplTest.testSession.consumptions, result!)
    }
    
    func testLoadConsumptionsWhenExistingSession() throws {
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
    
        stub(sessionRepository) { (stub) in
            when(stub.loadSession(sessionId: "10")).thenReturn(Observable.just(ConsumptionListViewModelImplTest.testSession))
        }
    
        let result = try underTest!.consumptions.toBlocking().first()
        
        XCTAssertEqual(ConsumptionListViewModelImplTest.testSession.consumptions, result!)
    }

    func testLoadConsumptionsWhenExistingSessionFailure() {
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
    
        stub(sessionRepository) { (stub) in
            when(stub.loadSession(sessionId: "10")).thenReturn(Observable.error(ConsumptionListViewModelImplTest.testError))
        }
    
        do {
            _ = try underTest!.consumptions.toBlocking().toArray()
            XCTFail()
        } catch {
            XCTAssertTrue(error is SimpleError)
            switch error as! SimpleError {
            case .error(let message):
                XCTAssertEqual(ConsumptionListViewModelImplTest.testErrorMessage, message)
            }
        }
    }

    func testDeleteConsumptionWhenSuccess() throws {
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
        stub(sessionRepository) { (stub) in
            when(stub.loadSession(sessionId: "10")).thenReturn(Observable.just(ConsumptionListViewModelImplTest.testSession))
        }
        stub(consumptionRepository) { (stub) in
            when(stub.delete(consumption: ConsumptionListViewModelImplTest.testConsumption1)).thenReturn(Completable.empty())
        }
    
        _ = try underTest!.delete(consumption: ConsumptionListViewModelImplTest.testConsumption1).toBlocking().toArray()
    
        verify(consumptionRepository).delete(consumption: ConsumptionListViewModelImplTest.testConsumption1)
    }

    func testDeleteConsumptionWhenError() {
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
    
        stub(consumptionRepository) { stub in
            when(stub.delete(consumption: ConsumptionListViewModelImplTest.testConsumption1)).thenReturn(
                Completable.error(ConsumptionListViewModelImplTest.testError)
            )
        }
    
        do {
            _ = try underTest!.delete(consumption: ConsumptionListViewModelImplTest.testConsumption1).toBlocking().toArray()
            XCTFail()
        } catch {
            if case SimpleError.error(let message) = error {
                XCTAssertEqual(ConsumptionListViewModelImplTest.testErrorMessage, message)
            } else {
                XCTFail("Invalid error type \(error)")
            }
        }
    
        verify(consumptionRepository).delete(consumption: ConsumptionListViewModelImplTest.testConsumption1)
    }
    
    func testAddDrinkWhenNoInProgressSession() throws {
        // GIVEN
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: nil)
        let testDrink = Drink(name: "test", alcohol: 10.0, defaultQuantity: 5.0, defaultUnit: DrinkUnit.deciliter)
        let testDate = createDate(2019, 1, 24, 13, 9, 32)
        dateProvider = TestDateProvider(date: testDate)
        
        let consumption = Consumption(drink: testDrink.name, quantity: testDrink.defaultQuantity, unit: testDrink.defaultUnit, alcohol: testDrink.alcohol, date: testDate)
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.never())
        }
        stub(consumptionRepository) { (stub) in
            when(stub.saveConsumption(sessionId: ConsumptionListViewModelImplTest.testSession.id, consumption: consumption)).thenReturn(Completable.empty())
        }
    
        stub(sessionRepository) { (stub) in when(stub.inProgressSession).get.thenReturn(Observable.never())
        }
    
        // WHEN
        _ = try underTest!.addDrinkAsConsumption(drink: testDrink).toBlocking().first()
    
        // THEN
        verifyNoMoreInteractions(consumptionRepository)
    }

    func testAddDrinkWhenSessionIdIsNotNil() throws {
        // GIVEN
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "12")
        let testDrink = Drink(name: "test", alcohol: 10.0, defaultQuantity: 5.0, defaultUnit: DrinkUnit.deciliter)
        let testDate = createDate(2019, 1, 24, 13, 9, 32)
        dateProvider = TestDateProvider(date: testDate)
        let consumption = Consumption(drink: testDrink.name, quantity: testDrink.defaultQuantity, unit: testDrink.defaultUnit, alcohol: testDrink.alcohol, date: testDate)
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.never())
        }
        stub(consumptionRepository) { (stub) in
            when(stub.saveConsumption(sessionId: "12", consumption: consumption)).thenReturn(Completable.empty())
        }
        stub(sessionRepository) { (stub) in
            when(stub.loadSession(sessionId: "12")).thenReturn(Observable<Session>.just(ConsumptionListViewModelImplTest.testSession))
        }
    
        // WHEN
        _ = try underTest!.addDrinkAsConsumption(drink: testDrink).toBlocking().first()
    
        // THEN
        verify(consumptionRepository).saveConsumption(sessionId: "12", consumption: Consumption(drink: testDrink.name, quantity: testDrink.defaultQuantity, unit: testDrink.defaultUnit, alcohol: testDrink.alcohol))
    }

    func testLoadFrequentlyConsumedDrinksWhenError() {
        // GIVEN
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "12")
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.error(ConsumptionListViewModelImplTest.testError))
        }
    
        // WHEN
        do {
            _ = try underTest!.drinks.toBlocking().first()
            XCTFail("Error have to be thrown!")
        } catch {
            if case SimpleError.error(let message) = error {
                XCTAssertEqual(ConsumptionListViewModelImplTest.testErrorMessage, message)
            } else {
                XCTFail("Invalid error type \(error)")
            }
        }
    }

    func testLoadFrequentlyConsumedDrinksWhenEmptyResult() throws {
        // GIVEN
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "12")
    
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.just([]))
        }
    
        // WHEN
        let result = try underTest!.drinks.toBlocking().first()
        
        // THEN
        XCTAssertTrue(result!.isEmpty)
    }

    func testLoadFrequentlyConsumedDrinksWhenSingleResult() throws {
        // GIVEN
        underTest = ConsumptionListViewModelImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository)
    
        let testDrink = Drink(name: "test")
        let testDrinks = [testDrink]
    
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.just(testDrinks))
        }
    
        // WHEN
        let result = try underTest!.drinks.toBlocking().first()

        // THEN
        XCTAssertEqual(testDrinks, result!)
    }

    func testLoadFrequentlyConsumedDrinksWhenResultCountLessThanLimit() throws {
        // GIVEN
        let testDrink1 = Drink(name: "test1")
        let testDrink2 = Drink(name: "test2")
        let testDrink3 = Drink(name: "test3")
        let testDrinks = [testDrink1, testDrink2, testDrink3]
    
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.just(testDrinks))
        }
    
        // WHEN
        let result = try underTest!.drinks.toBlocking().first()
    
        // THEN
        XCTAssertEqual(testDrinks, result!)
    }
    
    func testLoadFrequentlyConsumedDrinksWhENresultcoundMoreThanLimit() throws {
        // GIVEN
        let testDrink1 = Drink(name: "test1")
        let testDrink2 = Drink(name: "test2")
        let testDrink3 = Drink(name: "test3")
        let testDrink4 = Drink(name: "test4")
        let testDrinks = [testDrink1, testDrink2, testDrink3, testDrink4]
        let limitedList = [testDrink1, testDrink2, testDrink3]
    
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.just(testDrinks))
        }
    
        // WHEN
        let result = try underTest!.drinks.toBlocking().first()
    
        // THEN
        XCTAssertEqual(limitedList, result!)
    }
}
