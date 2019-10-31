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
    static let TEST_CONSUMPTION_1 = Consumption("1", drink: "test drink", quantity: 2.0, unit: DrinkUnit.DL, alcohol: 10.5)
    static let TEST_CONSUMPTION_2 = Consumption("2", drink: "test drink 2", quantity: 5.0, unit: DrinkUnit.CL, alcohol: 65.0)
    
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
            when(stub.getInProgressSession()).thenReturn(Maybe.error(ConsumptionListInteractorImplTest.TEST_ERROR))
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
            when(stub.getInProgressSession()).thenReturn(Maybe.empty())
        }
    
        do {
            _ = try underTest!.loadConsumptions().toBlocking().first()
            XCTFail("Error have to be thrown!")
        } catch {
            if case SimpleError.error(let message) = error {
                XCTAssertEqual("Session can't be loaded!", message)
            } else {
                XCTFail("Invalid error type")
            }
        }
    }

    func testLoadConsumptionsWhenInProgressSession() throws {
        stub(sessionRepository) { (stub) in
            when(stub.getInProgressSession()).thenReturn(Maybe.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }
    
        let result = try underTest!.loadConsumptions().toBlocking().first()
    
        XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_SESSION.consumptions, result!)
    }
    
    func testLoadConsumptionsWhenExistingSession() throws {
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
    
        stub(sessionRepository) { (stub) in
            when(stub.getSession(sessionId: "10")).thenReturn(Maybe.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }
    
        let result = try underTest!.loadConsumptions().toBlocking().first()
        
        XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_SESSION.consumptions, result!)
    }

    func testLoadConsumptionsWhenExistingSessionFailure() {
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "10")
    
        stub(sessionRepository) { (stub) in
            when(stub.getSession(sessionId: "10")).thenReturn(Maybe.error(ConsumptionListInteractorImplTest.TEST_ERROR))
        }
    
        do {
            _ = try underTest!.loadConsumptions().toBlocking().toArray()
            XCTFail("Error have to be thrown!")
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
            when(stub.getSession(sessionId: "10")).thenReturn(Maybe.just(ConsumptionListInteractorImplTest.TEST_SESSION))
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
            XCTFail("Error have to be thrown!")
        } catch {
            if case SimpleError.error(let message) = error {
                XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_ERROR_MESSAGE, message)
            } else {
                XCTFail("Invalid error type")
            }
        }
    
        verify(consumptionRepository).delete(consumption: ConsumptionListInteractorImplTest.TEST_CONSUMPTION_1)
    }
    
    func testAddDrinkWhenSessionIdIsNil() throws {
        // GIVEN
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: nil)
        let testDrink = Drink(name: "test", alcohol: 10.0, defaultQuantity: 5.0, defaultUnit: DrinkUnit.DL)
        let testDate = createDate(2019, 1, 24, 13, 9, 32)
        dateProvider = TestDateProvider(date: testDate)
        
        let consumption = Consumption(drink: testDrink.name, quantity: testDrink.defaultQuantity, unit: testDrink.defaultUnit, alcohol: testDrink.alcohol, date: testDate)
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Single.never())
        }
        stub(consumptionRepository) { (stub) in
            when(stub.saveConsumption(sessionId: ConsumptionListInteractorImplTest.TEST_SESSION.id, consumption: consumption)).thenReturn(Completable.empty())
        }
    
        stub(sessionRepository) { (stub) in when(stub.getInProgressSession()).thenReturn(Maybe.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }
    
        // WHEN
        _ = try underTest!.add(drink: testDrink).toBlocking().first()
    
        // THEN
        verify(consumptionRepository).saveConsumption(sessionId: ConsumptionListInteractorImplTest.TEST_SESSION.id, consumption: Consumption(drink: testDrink.name, quantity: testDrink.defaultQuantity, unit: testDrink.defaultUnit, alcohol: testDrink.alcohol))
    }

    func testAddDrinkWhenSessionIdIsNotNil() throws {
        // GIVEN
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "12")
        let testDrink = Drink(name: "test", alcohol: 10.0, defaultQuantity: 5.0, defaultUnit: DrinkUnit.DL)
        let testDate = createDate(2019, 1, 24, 13, 9, 32)
        dateProvider = TestDateProvider(date: testDate)
        let consumption = Consumption(drink: testDrink.name, quantity: testDrink.defaultQuantity, unit: testDrink.defaultUnit, alcohol: testDrink.alcohol, date: testDate)
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Single.never())
        }
        stub(consumptionRepository) { (stub) in
            when(stub.saveConsumption(sessionId: "12", consumption: consumption)).thenReturn(Completable.empty())
        }
        stub(sessionRepository) { (stub) in
            when(stub.getSession(sessionId: "12")).thenReturn(Maybe<Session>.just(ConsumptionListInteractorImplTest.TEST_SESSION))
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
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Single.error(ConsumptionListInteractorImplTest.TEST_ERROR))
        }
    
        // WHEN
        do {
            _ = try underTest!.loadFrequentlyConsumedDrinks().toBlocking().first()
            XCTFail("Error have to be thrown!")
        } catch {
            if case SimpleError.error(let message) = error {
                XCTAssertEqual(ConsumptionListInteractorImplTest.TEST_ERROR_MESSAGE, message)
            } else {
                XCTFail("Invalid error type")
            }
        }
    }

    func testLoadFrequentlyConsumedDrinksWhenEmptyResult() throws {
        // GIVEN
        underTest = ConsumptionListInteractorImpl(sessionRepository: sessionRepository, consumptionRepository: consumptionRepository, drinkRepository: drinkRepository, sessionId: "12")
    
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Single.just([]))
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
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Single.just(testDrinks))
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
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Single.just(testDrinks))
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
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Single.just(testDrinks))
        }
    
        // WHEN
        let result = try underTest!.loadFrequentlyConsumedDrinks().toBlocking().first()
    
        // THEN
        XCTAssertEqual(limitedList, result!)
    }
    
    func testLoadFrequentlyConsumedDrinksAfterAddingConsumption() throws {
        // GIVEN
        let testDrink1 = Drink(name: "test1")
        let testDrink2 = Drink(name: "test2")
        let testDrink3 = Drink(name: "test3")
        let testDrink4 = Drink(name: "test4")
        let testDrinks = [testDrink1, testDrink2]
        let testDrinksAfterChange = [testDrink1, testDrink2, testDrink4, testDrink3]
        let testDrinksAfterChange2 = [testDrink1, testDrink3, testDrink4, testDrink2]
        let limitedList = [testDrink1, testDrink2]
        let limitedListAfterChange = [testDrink1, testDrink2, testDrink4]
        let limitedListAfterChange2 = [testDrink1, testDrink3, testDrink4]
        
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Single.just(testDrinks), Single.just(testDrinksAfterChange), Single.just(testDrinksAfterChange2))
        }
        stub(sessionRepository) { (stub) in
            when(stub.getInProgressSession()).thenReturn(Maybe.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }
        stub(consumptionRepository) { (stub) in
            when(stub.saveConsumption(sessionId: anyString(), consumption: any(Consumption.self))).thenReturn(Completable.empty())
        }
        
        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver(DrinkArray.self)
        
        underTest!.loadFrequentlyConsumedDrinks()
            .map({ (drinks) -> DrinkArray in
                DrinkArray(drinks)
            })
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        let trigger = scheduler.createHotObservable([next(10, testDrink1), next(100, testDrink2)])
        
        trigger.flatMap { (drink) -> Completable in
            self.underTest!.add(drink: drink)
        }
            .subscribe()
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // WHEN
        XCTAssertEqual([
                next(0, DrinkArray(limitedList)),
                next(10, DrinkArray(limitedListAfterChange)),
                next(100, DrinkArray(limitedListAfterChange2))
            ], observer.events)
    }
    
    func testLoadFrequentlyConsumedDrinksAfterDeleteConsumption() throws {
        // GIVEN
        let testDrink1 = Drink(name: "test1")
        let testDrink2 = Drink(name: "test2")
        let testDrink3 = Drink(name: "test3")
        let testDrink4 = Drink(name: "test4")
        let testDrinks = [testDrink1, testDrink2]
        let testDrinksAfterChange = [testDrink1, testDrink2, testDrink4, testDrink3]
        let testDrinksAfterChange2 = [testDrink1, testDrink3, testDrink4, testDrink2]
        let limitedList = [testDrink1, testDrink2]
        let limitedListAfterChange = [testDrink1, testDrink2, testDrink4]
        let limitedListAfterChange2 = [testDrink1, testDrink3, testDrink4]
        
        stub(drinkRepository) { (stub) in
            when(stub.getFrequentlyConsumedDrinks()).thenReturn(Single.just(testDrinks), Single.just(testDrinksAfterChange), Single.just(testDrinksAfterChange2))
        }
        stub(sessionRepository) { (stub) in
            when(stub.getInProgressSession()).thenReturn(Maybe.just(ConsumptionListInteractorImplTest.TEST_SESSION))
        }
        stub(consumptionRepository) { (stub) in
            when(stub.saveConsumption(sessionId: anyString(), consumption: any(Consumption.self))).thenReturn(Completable.empty())
            when(stub.delete(consumption: any(Consumption.self))).thenReturn(Completable.empty())
        }
        
        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver(DrinkArray.self)
        
        underTest!.loadFrequentlyConsumedDrinks()
            .map({ (drinks) -> DrinkArray in
                DrinkArray(drinks)
            })
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        let trigger = scheduler.createHotObservable([next(10, Consumption()), next(100, Consumption())])
        
        trigger.flatMap { (consumption) -> Completable in
            self.underTest!.delete(consumption: consumption)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // WHEN
        XCTAssertEqual([
            next(0, DrinkArray(limitedList)),
            next(10, DrinkArray(limitedListAfterChange)),
            next(100, DrinkArray(limitedListAfterChange2))
            ], observer.events)
    }
}
