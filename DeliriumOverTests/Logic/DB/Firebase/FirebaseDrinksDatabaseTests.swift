//
//  FirebaseDrinksDatabaseTests.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 10. 04..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import Cuckoo
import FirebaseDatabase
import XCTest
@testable import DeliriumOver

class FirebaseDrinksDatabaseTests: XCTestCase {
    private let firebaseDatabase = MockFirebaseDatabaseReference()
    private let drinksNode = MockFirebaseDatabaseReference()
    private lazy var underTest = FirebaseDrinksDatabase(firebaseDatabase: firebaseDatabase)

    override func setUp() {
        stub(firebaseDatabase) { mock in
            mock.child("drinks").thenReturn(drinksNode)
        }
    }

    func testGetDrinks() {
        let drinks = [
            Drink(name: "sor", alcohol: 5, defaultQuantity: 5, defaultUnit: .deciliter, drinkType: DrinkType.BEER, localization: ["sor": "beer"]),
            Drink(name: "bor", alcohol: 11, defaultQuantity: 1, defaultUnit: .deciliter, drinkType: DrinkType.WINE, localization: ["bor": "wine"]),
            Drink(name: "palinka", alcohol: 55, defaultQuantity: 5, defaultUnit: .centiliter, drinkType: DrinkType.SCHNAPPS, localization: ["palinka": "palinka"])
        ]
        let successfulHandler = ArgumentCaptor<(DataSnapshot) -> Void>()
        let cancelHandler = ArgumentCaptor<((Error) -> Void)?>()
        stub(drinksNode) { mock in
            mock.observeSingleEvent(of: DataEventType.value, with: successfulHandler.capture(), withCancel: cancelHandler.capture()).thenDoNothing()
        }

        let emission = expectation(description: "Waiting for emission")

        _ = underTest.getDrinks().subscribe(onSuccess: { (result) in
            XCTAssertEqual(drinks, result)
            emission.fulfill()
        })

        successfulHandler.value!(MockDataSnapshot(mockData: drinks))

        waitForExpectations(timeout: 2)
    }

    func testGetDrinksWhenError() {
        let error = "ERROR"
        let successfulHandler = ArgumentCaptor<(DataSnapshot) -> Void>()
        let cancelHandler = ArgumentCaptor<((Error) -> Void)?>()
        stub(drinksNode) { mock in
            mock.observeSingleEvent(of: DataEventType.value, with: successfulHandler.capture(), withCancel: cancelHandler.capture()).thenDoNothing()
        }

        let emission = expectation(description: "Waiting for emission")

        _ = underTest.getDrinks().subscribe(onError: { (e) in
            XCTAssertEqual(error, e as! String)
            emission.fulfill()
        })

        cancelHandler.value!!(error)

        waitForExpectations(timeout: 2)
    }
}
