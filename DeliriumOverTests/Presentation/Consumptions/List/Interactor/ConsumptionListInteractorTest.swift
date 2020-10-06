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

class ConsumptionListInteractorImplTest: XCTestCase {
    private static let TEST_ERROR_MESSAGE = "TEST ERROR"
    private static let TEST_ERROR: SimpleError = SimpleError.error(message: TEST_ERROR_MESSAGE)
    static let TEST_CONSUMPTION_1 = Consumption("1", drink: "test drink", quantity: 2.0, unit: DrinkUnit.deciliter, alcohol: 10.5)
    static let TEST_CONSUMPTION_2 = Consumption("2", drink: "test drink 2", quantity: 5.0, unit: DrinkUnit.centiliter, alcohol: 65.0)
    
    static let TEST_SESSION = Session(
        id: "10",
        title: "Test session",
        description: "Test description",
        name: "Test Name",
        weight: 85.0,
        height: 175.0,
        gender: Sex.MALE,
        consumptions: [TEST_CONSUMPTION_1, TEST_CONSUMPTION_2],
        inProgress: false
    )
    var sessionRepository = MockSessionRepository()
    var consumptionRepository = MockConsumptionRepository()
    var drinkRepository = MockDrinkRepository()
    var underTest: ConsumptionListInteractorImpl?
    
    override func setUp() {
        super.setUp()
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository)
    }
    
    func testLoadConsumptionsWhenLoadSessionFailure() {
        stub(sessionRepository) { (stub) in
            when(stub.inProgressSession).get.thenReturn(Observable.error(ConsumptionListInteractorImplTest.TEST_ERROR))
        }

        do {
            _ = try underTest!.loadConsumptions().toBlocking().first()
            XCTFail("Expected result is to throw error.")
        } catch {
            XCTAssertTrue(error is SimpleError)
            switch error as! SimpleError {
            case .error(let message):
                XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_ERROR_MESSAGE, message)
            }
        }
    }

    func testLoadConsumptionsWhenNoSession() throws {
        stub(sessionRepository) { (stub) in
            when(stub.inProgressSession).get.thenReturn(Observable.empty())
        }
    
        do {
            _ = try underTest!.loadConsumptions().toBlocking().first()
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
            when(stub.inProgressSession).get.thenReturn(Observable.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }
    
        let result = try underTest!.loadConsumptions().toBlocking().first()
    
        XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_SESSION.consumptions, result!)
    }
    func testLoadConsumptionsWhenInProgressSession2() throws {
        stub(sessionRepository) { (stub) in
            when(stub.inProgressSession).get.thenReturn(Observable.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }

        let result = try underTest!.loadConsumptions().toBlocking().first()

        XCTFail()
    }

    func testLoadConsumptionsWhenInProgressSession3() throws {
        stub(sessionRepository) { (stub) in
            when(stub.inProgressSession).get.thenReturn(Observable.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }

        let result = try underTest!.loadConsumptions().toBlocking().first()

    }

    func testLoadConsumptionsWhenInProgressSession4() throws {
        stub(sessionRepository) { (stub) in
            when(stub.inProgressSession).get.thenReturn(Observable.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }

        let result = try underTest!.loadConsumptions().toBlocking().first()

        XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_SESSION.consumptions, [])
    }
    
    func testLoadConsumptionsWhenExistingSession() throws {
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
    
        stub(sessionRepository) { (stub) in
            when(stub.loadSession(sessionId: "10")).thenReturn(Observable.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }
    
        let result = try underTest!.loadConsumptions().toBlocking().first()
        
        XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_SESSION.consumptions, result!)
    }

    func testLoadConsumptionsWhenExistingSessionFailure() {
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
    
        stub(sessionRepository) { (stub) in
            when(stub.loadSession(sessionId: "10")).thenReturn(Observable.error(ConsumptionListInteractorImplTest.TEST_ERROR))
        }
    
        do {
            _ = try underTest!.loadConsumptions().toBlocking().toArray()
            XCTFail()
        } catch {
            XCTAssertTrue(error is SimpleError)
            switch error as! SimpleError {
            case .error(let message):
                XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_ERROR_MESSAGE, message)
            }
        }
    }

    func testDeleteConsumptionWhenSuccess() throws {
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
        stub(sessionRepository) { (stub) in
            when(stub.loadSession(sessionId: "10")).thenReturn(Observable.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }
        stub(consumptionRepository) { (stub) in
            when(stub.delete(consumption: ConsumptionListInteractorImplTest.TEST_CONSUMPTION_1)).thenReturn(Completable.empty())
        }
    
        _ = try underTest!.delete(consumption: ConsumptionListInteractorImplTest.TEST_CONSUMPTION_1).toBlocking().toArray()
    
        verify(consumptionRepository).delete(consumption: ConsumptionListInteractorImplTest.TEST_CONSUMPTION_1)
    }

    func testDeleteConsumptionWhenError() {
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
    
        stub(consumptionRepository) { stub in
            when(stub.delete(consumption: ConsumptionListInteractorImplTest.TEST_CONSUMPTION_1)).thenReturn(
                Completable.error(ConsumptionListInteractorImplTest.TEST_ERROR)
            )
        }
    
        do {
            _ = try underTest!.delete(consumption: ConsumptionListInteractorImplTest.TEST_CONSUMPTION_1).toBlocking().toArray()
            XCTFail()
        } catch {
            if case SimpleError.error(let message) = error {
                XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_ERROR_MESSAGE, message)
            } else {
                XCTFail("Invalid error type \(error)")
            }
        }
    
        verify(consumptionRepository).delete(consumption: ConsumptionListInteractorImplTest.TEST_CONSUMPTION_1)
    }
    
    func testAddDrinkWhenNoInProgressSession() throws {
        // GIVEN
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: nil)
        let testDrink = Drink(name: "test", alcohol: 10.0, defaultQuantity: 5.0, defaultUnit: DrinkUnit.deciliter)
        let testDate = createDate(2019, 1, 24, 13, 9, 32)
        dateProvider = TestDateProvider(date: testDate)
        
        let consumption = Consumption(drink: testDrink.name, quantity: testDrink.defaultQuantity, unit: testDrink.defaultUnit, alcohol: testDrink.alcohol, date: testDate)
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.never())
        }
        stub(consumptionRepository) { (stub) in
            when(stub.saveConsumption(sessionId: ConsumptionListInteractorImplTest.TEST_SESSION.id, consumption: consumption)).thenReturn(Completable.empty())
        }
    
        stub(sessionRepository) { (stub) in when(stub.inProgressSession).get.thenReturn(Observable.never())
        }
    
        // WHEN
        _ = try underTest!.add(drink: testDrink).toBlocking().first()
    
        // THEN
        verifyNoMoreInteractions(consumptionRepository)
//        verify(consumptionRepository).saveConsumption(sessionId: ConsumptionListInteractorImplTest.TEST_SESSION.id, consumption: Consumption(drink: testDrink.name, quantity: testDrink.defaultQuantity, unit: testDrink.defaultUnit, alcohol: testDrink.alcohol))
    }

    func testAddDrinkWhenSessionIdIsNotNil() throws {
        // GIVEN
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "12")
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
            when(stub.loadSession(sessionId: "12")).thenReturn(Observable<Session>.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }
    
        // WHEN
        _ = try underTest!.add(drink: testDrink).toBlocking().first()
    
        // THEN
        verify(consumptionRepository).saveConsumption(sessionId: "12", consumption: Consumption(drink: testDrink.name, quantity: testDrink.defaultQuantity, unit: testDrink.defaultUnit, alcohol: testDrink.alcohol))
    }

    func testLoadFrequentlyConsumedDrinksWhenError() {
        // GIVEN
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "12")
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.error(ConsumptionListInteractorImplTest.TEST_ERROR))
        }
    
        // WHEN
        do {
            _ = try underTest!.loadFrequentlyConsumedDrinks().toBlocking().first()
            XCTFail("Error have to be thrown!")
        } catch {
            if case SimpleError.error(let message) = error {
                XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_ERROR_MESSAGE, message)
            } else {
                XCTFail("Invalid error type \(error)")
            }
        }
    }

    func testLoadFrequentlyConsumedDrinksWhenEmptyResult() throws {
        // GIVEN
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "12")
    
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.just([]))
        }
    
        // WHEN
        let result = try underTest!.loadFrequentlyConsumedDrinks().toBlocking().first()
        
        // THEN
        XCTAssertTrue(result!.isEmpty)
    }

    func testLoadFrequentlyConsumedDrinksWhenSingleResult() throws {
        // GIVEN
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository)
    
        let testDrink = Drink(name: "test")
        let testDrinks = [testDrink]
    
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Observable.just(testDrinks))
        }
    
        // WHEN
        let result = try underTest!.loadFrequentlyConsumedDrinks().toBlocking().first()

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
        let result = try underTest!.loadFrequentlyConsumedDrinks().toBlocking().first()
    
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
        let result = try underTest!.loadFrequentlyConsumedDrinks().toBlocking().first()
    
        // THEN
        XCTAssertEqual(limitedList, result!)
    }
}
