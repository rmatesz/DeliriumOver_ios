//
//  AlcoholCalculatorTest.swift
//  DeliriumOverTests
//
//  Created by Mate on 2019. 01. 31..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import XCTest
@testable import DeliriumOver

public let DELTA: Double = 1E-6

let BEER_ALCOHOL_G = 15.78
let BEER_STRONG_ALCOHOL_G = 23.67
let PALINKA_ALCOHOL_G = 23.67
let WINE_ALCOHOL_G = 12.624
let MARTINI_ALCOHOL_G = 12.624
let WHISKY_ALCOHOL_G = 39.45
let VODKA_ALCOHOL_G = 14.991
let CHAMPAGNE_ALCOHOL_G = 9.0735

let BEER_ALCOHOL_P = 0.04
let BEER_STRONG_ALCOHOL_P = 0.06
let PALINKA_ALCOHOL_P = 0.60
let WINE_ALCOHOL_P = 0.08
let MARTINI_ALCOHOL_P = 0.16
let WHISKY_ALCOHOL_P = 0.5
let VODKA_ALCOHOL_P = 0.38
let CHAMPAGNE_ALCOHOL_P = 0.115
class AlcoholCalculatorTest: XCTestCase {


    private var underTest: AlcoholCalculator = AlcoholCalculator()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCalcAlcoholWeight() {
        let beer = underTest.calcAlcoholWeight(quantity: 0.5, drinkUnit: DrinkUnit.L, alcohol: BEER_ALCOHOL_P)
        let beerStrong = underTest.calcAlcoholWeight(quantity: 0.5, drinkUnit: DrinkUnit.L, alcohol: BEER_STRONG_ALCOHOL_P)
        let wine = underTest.calcAlcoholWeight(quantity: 2.0, drinkUnit: DrinkUnit.DL, alcohol: WINE_ALCOHOL_P)
        let palinka = underTest.calcAlcoholWeight(quantity: 5.0, drinkUnit: DrinkUnit.CL, alcohol: PALINKA_ALCOHOL_P)
        let martini = underTest.calcAlcoholWeight(quantity: 1.0, drinkUnit: DrinkUnit.DL, alcohol: MARTINI_ALCOHOL_P)
        let whisky = underTest.calcAlcoholWeight(quantity: 1.0, drinkUnit: DrinkUnit.DL, alcohol: WHISKY_ALCOHOL_P)
        let vodka = underTest.calcAlcoholWeight(quantity: 0.5, drinkUnit: DrinkUnit.DL, alcohol: VODKA_ALCOHOL_P)
        let champagne = underTest.calcAlcoholWeight(quantity: 1.0, drinkUnit: DrinkUnit.DL, alcohol: CHAMPAGNE_ALCOHOL_P)
        XCTAssertEqual(BEER_ALCOHOL_G, beer, accuracy: DELTA)
        XCTAssertEqual(BEER_STRONG_ALCOHOL_G, beerStrong)
        XCTAssertEqual(WINE_ALCOHOL_G, wine)
        XCTAssertEqual(PALINKA_ALCOHOL_G, palinka)
        XCTAssertEqual(MARTINI_ALCOHOL_G, martini)
        XCTAssertEqual(WHISKY_ALCOHOL_G, whisky)
        XCTAssertEqual(VODKA_ALCOHOL_G, vodka, accuracy: DELTA)
        XCTAssertEqual(CHAMPAGNE_ALCOHOL_G, champagne, accuracy: DELTA)
    }
    
    func testCalcBloodAlcoholConcentrationForMale() {
    XCTAssertEqual(
    0.26521008403361346,
    underTest.calcBloodAlcoholConcentration(alcohol: BEER_ALCOHOL_G, gender: Sex.MALE, weight: 85.0)
    )
    XCTAssertEqual(
    0.8670329670329671,
    underTest.calcBloodAlcoholConcentration(
        alcohol: BEER_ALCOHOL_G + PALINKA_ALCOHOL_G,
        gender: Sex.MALE,
        weight: 65.0
    )
    )
    XCTAssertEqual(
    0.6630252100840337,
    underTest.calcBloodAlcoholConcentration(
        alcohol: BEER_ALCOHOL_G + BEER_STRONG_ALCOHOL_G,
        gender: Sex.MALE,
        weight: 85.0
    )
    )
    XCTAssertEqual(
    0.39781512605042024,
    underTest.calcBloodAlcoholConcentration(alcohol: BEER_STRONG_ALCOHOL_G, gender: Sex.MALE, weight: 85.0)
    )
    XCTAssertEqual(
    Double.infinity,
    underTest.calcBloodAlcoholConcentration(alcohol: BEER_STRONG_ALCOHOL_G, gender: Sex.MALE, weight: 0.0)
    )
    }
    
    func testCalcBloodAlcoholConcentrationForFemale() {
    XCTAssertEqual(
    0.30941176470588233,
    underTest.calcBloodAlcoholConcentration(alcohol: BEER_ALCOHOL_G, gender: Sex.FEMALE, weight: 85.0)
    )
    XCTAssertEqual(
    1.0115384615384615384615384615385,
    underTest.calcBloodAlcoholConcentration(
        alcohol: BEER_ALCOHOL_G + PALINKA_ALCOHOL_G,
        gender: Sex.FEMALE,
        weight: 65.0
    ), accuracy: DELTA
    )
    XCTAssertEqual(
    0.77352941176470588235294117647059,
    underTest.calcBloodAlcoholConcentration(
        alcohol: BEER_ALCOHOL_G + BEER_STRONG_ALCOHOL_G,
        gender: Sex.FEMALE,
        weight: 85.0
    ), accuracy: DELTA
    )
    XCTAssertEqual(
    0.46411764705882352941176470588235,
    underTest.calcBloodAlcoholConcentration(alcohol: BEER_STRONG_ALCOHOL_G, gender: Sex.FEMALE, weight: 85.0), accuracy: DELTA
    )
    XCTAssertEqual(
    Double.infinity,
    underTest.calcBloodAlcoholConcentration(alcohol: BEER_STRONG_ALCOHOL_G, gender: Sex.FEMALE, weight: 0.0)
    )
    }
}
