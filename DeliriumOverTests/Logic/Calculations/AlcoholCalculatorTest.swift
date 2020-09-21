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

let DATE_NOW = createDate(2018, 1, 26, 23, 59, timezone: TimeZone(abbreviation: "UTC")!)

class AlcoholCalculatorTest: XCTestCase {


    private var underTest: AlcoholCalculator = AlcoholCalculator()
    private let params: [[Any]] = setupParams()
    
    override func setUp() {
        super.setUp()
        dateProvider = TestDateProvider(date: DATE_NOW)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCalcAlcoholWeight() {
        let beer = underTest.calcAlcoholWeight(quantity: 0.5, drinkUnit: DrinkUnit.liter, alcohol: BEER_ALCOHOL_P)
        let beerStrong = underTest.calcAlcoholWeight(quantity: 0.5, drinkUnit: DrinkUnit.liter, alcohol: BEER_STRONG_ALCOHOL_P)
        let wine = underTest.calcAlcoholWeight(quantity: 2.0, drinkUnit: DrinkUnit.deciliter, alcohol: WINE_ALCOHOL_P)
        let palinka = underTest.calcAlcoholWeight(quantity: 5.0, drinkUnit: DrinkUnit.centiliter, alcohol: PALINKA_ALCOHOL_P)
        let martini = underTest.calcAlcoholWeight(quantity: 1.0, drinkUnit: DrinkUnit.deciliter, alcohol: MARTINI_ALCOHOL_P)
        let whisky = underTest.calcAlcoholWeight(quantity: 1.0, drinkUnit: DrinkUnit.deciliter, alcohol: WHISKY_ALCOHOL_P)
        let vodka = underTest.calcAlcoholWeight(quantity: 0.5, drinkUnit: DrinkUnit.deciliter, alcohol: VODKA_ALCOHOL_P)
        let champagne = underTest.calcAlcoholWeight(quantity: 1.0, drinkUnit: DrinkUnit.deciliter, alcohol: CHAMPAGNE_ALCOHOL_P)
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
    
    func testCalcBACDuringAbsorption() {
        for param in params {
            XCTAssertEqual(
                getBacDuringAbsorption(param),
                underTest.calcBloodAlcoholConcentration(session: getSession(param), date: getAbsorptionDate(param)),
                accuracy: 0.001
            )
        }
    }
    
    func testCalcBACWhenAtMaximum() {
        for param in params {
            XCTAssertEqual(
                getBacWhenMaximum(param),
                underTest.calcBloodAlcoholConcentration(session: getSession(param), date: getMaximumBacDate(param)),
                accuracy: DELTA
            )
        }
    }

    func testCalcBACDuringElimination() {
        for param in params {
            XCTAssertEqual(
                getBacDuringElimination(param),
                underTest.calcBloodAlcoholConcentration(session: getSession(param), date: getDuringEliminationDate(param)),
                accuracy: DELTA
            )
        }
    }

    func testCalcBACAfterElimination() {
        for param in params {
            XCTAssertEqual(
            0.0,
            underTest.calcBloodAlcoholConcentration(session: getSession(param), date: getAfterEliminationDate(param)),
            accuracy: DELTA
            )
        }
    }

    func testCalcTimeOfZeroBAC() {
        for param in params {
            XCTAssertEqual(getZeroBacDate(param).timeIntervalSince1970, underTest.calcTimeOfZeroBAC(getSession(param)).timeIntervalSince1970, accuracy: 1 - DELTA)
        }
    }

    func testCalculations() {
        for param in params {
            XCTAssertEqual(
                0.0,
                underTest.calcBloodAlcoholConcentration(session: getSession(param), date: underTest.calcTimeOfZeroBAC(getSession(param))),
                accuracy: DELTA
            )
        }
    }

    func testCalcBloodAlcoholConcentrationBeforeDrink() {
        for param in params {
            XCTAssertEqual(
                0.0,
                underTest.calcBloodAlcoholConcentration(
                    session: getSession(param),
                    date: createDate(2018, 1, 26, 12, 0, timezone: TimeZone(abbreviation: "UTC")!)
                ),
                accuracy: DELTA
            )
        }
    }

    func testGenerateRecords() {
        for param in params {
            let records = getRecords(param)
            let result = underTest.generateRecords(session: getSession(param))
            print("expected: ")
            print(records)
            print("\n")
            print("actual: ")
            print(result)
            XCTAssertEqual(records.count, result.count)
            for i in 0..<records.count {
                XCTAssertEqual(records[i].time.timeIntervalSince1970, result[i].time.timeIntervalSince1970, accuracy: 1 - DELTA)
                XCTAssertEqual(records[i].bacLevel, result[i].bacLevel, accuracy: DELTA)
            }
        }
    }
    
    func getSession(_ params: [Any]) -> Session {
        return params[0] as! Session
    }
    func getAbsorptionDate(_ params: [Any]) -> Date {
        return params[1] as! Date
    }
    func getBacDuringAbsorption(_ params: [Any]) -> Double {
        return params[2] as! Double
    }
    func getMaximumBacDate(_ params: [Any]) -> Date {
        return params[3] as! Date
    }
    func getBacWhenMaximum(_ params: [Any]) -> Double {
        return params[4] as! Double
    }
    func getDuringEliminationDate(_ params: [Any]) -> Date {
        return params[5] as! Date
    }
    func getBacDuringElimination(_ params: [Any]) -> Double {
        return params[6] as! Double
    }
    func getAfterEliminationDate(_ params: [Any]) -> Date {
        return params[7] as! Date
    }
    func getZeroBacDate(_ params: [Any]) -> Date {
        return params[8] as! Date
    }
    func getRecords(_ params: [Any]) -> [RecordData] {
        return params[9] as! [RecordData]
    }
    
    static func setupParams() -> [[Any]] {
        var params: [[Any]] = []
        
        var consumptions: [Consumption]
        var session: Session
        var absorptionDate: Date
        var bacDuringAbsorption: Double
        var maximumBacDate: Date
        var bacWhenMaximum: Double
        var duringEliminationDate: Date
        var bacDuringElimination: Double
        var afterEliminationDate: Date
        var zeroBacDate: Date
        var records: [RecordData]
        
        // One Beer
        consumptions = [Consumption(
                "0",
                drink: "sör",
                quantity: 0.5,
                unit: DrinkUnit.liter,
                alcohol: BEER_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            )]
        session = Session(title: "One beer", weight: 85.0, consumptions: consumptions)
        absorptionDate = createDate(2018, 1, 26, 13, 10, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.0634
        maximumBacDate = createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.1902100840336135
        duringEliminationDate =
            createDate(2018, 1, 26, 14, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.11521008403361352
        afterEliminationDate =
            createDate(2018, 1, 26, 16, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate = createDate(2018, 1, 26, 14, 46, 5, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.1902100840336135
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        // One beer - zero weight
        consumptions = [
            Consumption(
                "0",
                drink: "sör",
                quantity: 0.5,
                unit: DrinkUnit.liter,
                alcohol: BEER_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session =
            Session(title: "One beer - zero weight", weight: 0.0, consumptions: consumptions)
        absorptionDate = createDate(2018, 1, 26, 13, 10, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.06553356282271947
        maximumBacDate = createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.19660068846815837
        duringEliminationDate =
            createDate(2018, 1, 26, 14, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.12160068846815839
        afterEliminationDate =
            createDate(2018, 1, 26, 16, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate =
            createDate(2018, 1, 26, 14, 48, 38, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.19660068846815837
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        consumptions = [
            Consumption(
                "0",
                drink: "sör",
                quantity: 0.5,
                unit: DrinkUnit.liter,
                alcohol: BEER_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(
            title: "One beer - zero weight female",
            weight: 0.0,
            gender: Sex.FEMALE,
            consumptions: consumptions
        )
        absorptionDate = createDate(2018, 1, 26, 13, 10, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.10205314009661837
        maximumBacDate = createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.3061594202898551
        duringEliminationDate =
            createDate(2018, 1, 26, 14, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.23115942028985512
        afterEliminationDate =
            createDate(2018, 1, 26, 16, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate =
            createDate(2018, 1, 26, 15, 32, 27, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.3061594202898551
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        // One Beer - Female
        consumptions = [
            Consumption(
                "0",
                drink: "sör",
                quantity: 0.5,
                unit: DrinkUnit.liter,
                alcohol: BEER_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(
            title: "One beer - Female",
            weight: 85.0,
            gender: Sex.FEMALE,
            consumptions: consumptions
        )
        absorptionDate = createDate(2018, 1, 26, 13, 10, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.0781
        maximumBacDate = createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.23441176470588238
        duringEliminationDate =
            createDate(2018, 1, 26, 14, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.1594117647058824
        afterEliminationDate =
            createDate(2018, 1, 26, 15, 30, 46, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate = createDate(2018, 1, 26, 15, 3, 46, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.23441176470588238
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        // One sip
        consumptions = [
            Consumption(
                "0",
                drink: "sör",
                quantity: 1.0,
                unit: DrinkUnit.deciliter,
                alcohol: 0.02,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(title: "One sip", weight: 65.0, consumptions: consumptions)
        absorptionDate = createDate(2018, 1, 26, 13, 10, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.0
        maximumBacDate = createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.0
        duringEliminationDate =
            createDate(2018, 1, 26, 13, 31, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.0
        afterEliminationDate =
            createDate(2018, 1, 26, 14, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate = createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.0
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        consumptions = [
            Consumption(
                "0",
                drink: "sör",
                quantity: 5.0,
                unit: DrinkUnit.deciliter,
                alcohol: BEER_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            ),
            Consumption(
                "0",
                drink: "palinka",
                quantity: 5.0,
                unit: DrinkUnit.centiliter,
                alcohol: PALINKA_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 10, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(
            title: "Beer + Palinka in 10 minutes",
            weight: 65.0,
            consumptions: consumptions
        )
        absorptionDate = createDate(2018, 1, 26, 13, 20, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.3546153846153846
        maximumBacDate = createDate(2018, 1, 26, 13, 40, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.7670329670329671
        duringEliminationDate =
            createDate(2018, 1, 26, 14, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.717032967032967
        afterEliminationDate =
            createDate(2018, 1, 26, 19, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate =
            createDate(2018, 1, 26, 18, 46, 49, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 10, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.09060439560439561
            ),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.6186263736263737
            ),
            RecordData(
                time: createDate(2018, 1, 26, 13, 40, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.7670329670329671
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        consumptions = [
            Consumption(
                "0",
                drink: "sör",
                quantity: 5.0,
                unit: DrinkUnit.deciliter,
                alcohol: BEER_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            ),
            Consumption(
                "0",
                drink: "palinka",
                quantity: 5.0,
                unit: DrinkUnit.centiliter,
                alcohol: PALINKA_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 10, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(
            title: "Beer + Palinka in 10 minutes - Female",
            weight: 65.0,
            gender: Sex.FEMALE,
            consumptions: consumptions
        )
        absorptionDate = createDate(2018, 1, 26, 13, 20, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.4221
        maximumBacDate = createDate(2018, 1, 26, 13, 40, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.9115384615384617
        duringEliminationDate =
            createDate(2018, 1, 26, 14, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.8615384615384617
        afterEliminationDate =
            createDate(2018, 1, 26, 20, 46, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate =
            createDate(2018, 1, 26, 19, 44, 37, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 10, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.10987179487179488
            ),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.7342307692307694
            ),
            RecordData(
                time: createDate(2018, 1, 26, 13, 40, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.9115384615384617
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        consumptions = [
            Consumption(
                "0",
                drink: "sör",
                quantity: 5.0,
                unit: DrinkUnit.deciliter,
                alcohol: BEER_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            ),
            Consumption(
                "0",
                drink: "sör",
                quantity: 5.0,
                unit: DrinkUnit.deciliter,
                alcohol: BEER_STRONG_ALCOHOL_P,
                date: createDate(2018, 1, 26, 14, 0, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(
            title: "Two beers in 1 hour period",
            weight: 85.0,
            consumptions: consumptions
        )
        absorptionDate = createDate(2018, 1, 26, 14, 10, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.2228
        maximumBacDate = createDate(2018, 1, 26, 14, 30, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.4380252100840337
        duringEliminationDate =
            createDate(2018, 1, 26, 15, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.3630252100840337
        afterEliminationDate =
            createDate(2018, 1, 26, 18, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate =
            createDate(2018, 1, 26, 17, 25, 12, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.1902100840336135
            ),
            RecordData(
                time: createDate(2018, 1, 26, 14, 0, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.11521008403361352
            ),
            RecordData(
                time: createDate(2018, 1, 26, 14, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.4380252100840337
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        consumptions = [
            Consumption(
                "0",
                drink: "sör",
                quantity: 5.0,
                unit: DrinkUnit.deciliter,
                alcohol: BEER_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            ),
            Consumption(
                "0",
                drink: "sör",
                quantity: 5.0,
                unit: DrinkUnit.deciliter,
                alcohol: BEER_STRONG_ALCOHOL_P,
                date: createDate(2018, 1, 26, 18, 0, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(
            title: "One beer at afternoon, One beer in evening",
            weight: 65.0,
            consumptions: consumptions
        )
        absorptionDate = createDate(2018, 1, 26, 18, 10, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.1484
        maximumBacDate = createDate(2018, 1, 26, 18, 30, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.4452197802197802
        duringEliminationDate =
            createDate(2018, 1, 26, 19, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.3702197802197802
        afterEliminationDate =
            createDate(2018, 1, 26, 22, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate = createDate(2018, 1, 26, 21, 28, 6, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.27181318681318684
            ),
            RecordData(time: createDate(2018, 1, 26, 18, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 18, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.4452197802197802
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        consumptions = [
            Consumption(
                "0",
                drink: "sör",
                quantity: 5.0,
                unit: DrinkUnit.deciliter,
                alcohol: BEER_STRONG_ALCOHOL_P,
                date: createDate(2018, 1, 26, 18, 0, timezone: TimeZone(abbreviation: "UTC")!)
            ),
            Consumption(
                "0",
                drink: "sör",
                quantity: 5.0,
                unit: DrinkUnit.deciliter,
                alcohol: BEER_ALCOHOL_P,
                date: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(
            title: "One beer at afternoon, One beer in evening 2",
            weight: 65.0,
            consumptions: consumptions
        )
        absorptionDate = createDate(2018, 1, 26, 18, 10, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 0.1484
        maximumBacDate = createDate(2018, 1, 26, 18, 30, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 0.4452197802197802
        duringEliminationDate =
            createDate(2018, 1, 26, 19, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 0.3702197802197802
        afterEliminationDate =
            createDate(2018, 1, 26, 22, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate = createDate(2018, 1, 26, 21, 28, 6, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 13, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.27181318681318684
            ),
            RecordData(time: createDate(2018, 1, 26, 18, 0, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 18, 30, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.4452197802197802
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        consumptions = [
            Consumption(
                "2361",
                drink: "sör",
                quantity: 10.0,
                unit: DrinkUnit.liter,
                alcohol: 0.045,
                date: createDate(2018, 9, 5, 17, 5, timezone: TimeZone(abbreviation: "UTC")!)
            ),
            Consumption(
                "2362",
                drink: "palinka",
                quantity: 2.0,
                unit: DrinkUnit.deciliter,
                alcohol: 0.5,
                date: createDate(2018, 9, 5, 17, 5, timezone: TimeZone(abbreviation: "UTC")!)
            ),
            Consumption(
                "2367",
                drink: "sör",
                quantity: 1.0,
                unit: DrinkUnit.liter,
                alcohol: 0.045,
                date: createDate(2018, 9, 5, 17, 5, 27, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(title: "Vedelés", weight: 65.0, consumptions: consumptions)
        absorptionDate = createDate(2018, 9, 5, 17, 15, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 3.4025
        maximumBacDate =
            createDate(2018, 9, 5, 17, 35, 27, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 10.241567307692309
        duringEliminationDate =
            createDate(2018, 9, 7, 18, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 2.9801923076923087
        afterEliminationDate =
            createDate(2018, 9, 8, 18, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate = createDate(2018, 9, 8, 13, 52, 5, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 9, 5, 17, 5, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(time: createDate(2018, 9, 5, 17, 5, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 9, 5, 17, 5, 27, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 0.14193543956043958
            ),
            RecordData(
                time: createDate(2018, 9, 5, 17, 35, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 10.230987362637364
            ),
            RecordData(
                time: createDate(2018, 9, 5, 17, 35, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 10.230987362637364
            ),
            RecordData(
                time: createDate(2018, 9, 5, 17, 35, 27, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 10.241567307692309
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        consumptions = [
            Consumption(
                "2361",
                drink: "sör",
                quantity: 10.0,
                unit: DrinkUnit.liter,
                alcohol: 0.045,
                date: createDate(2018, 1, 26, 17, 5, timezone: TimeZone(abbreviation: "UTC")!)
            ),
            Consumption(
                "2362",
                drink: "palinka",
                quantity: 2.0,
                unit: DrinkUnit.deciliter,
                alcohol: 0.5,
                date: createDate(2018, 1, 26, 17, 5, timezone: TimeZone(abbreviation: "UTC")!)
            ),
            Consumption(
                "2367",
                drink: "sör",
                quantity: 1.0,
                unit: DrinkUnit.liter,
                alcohol: 0.045,
                date: createDate(2018, 1, 27, 1, 5, 27, timezone: TimeZone(abbreviation: "UTC")!)
            )
        ]
        session = Session(title: "Vedelés közben", weight: 65.0, consumptions: consumptions)
        absorptionDate = createDate(2018, 1, 26, 17, 15, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringAbsorption = 3.1542
        maximumBacDate =
            createDate(2018, 1, 26, 17, 35, 27, timezone: TimeZone(abbreviation: "UTC")!)
        bacWhenMaximum = 9.46123763736264
        duringEliminationDate =
            createDate(2018, 1, 28, 18, 0, timezone: TimeZone(abbreviation: "UTC")!)
        bacDuringElimination = 2.9801923076923087
        afterEliminationDate =
            createDate(2018, 1, 29, 18, 0, timezone: TimeZone(abbreviation: "UTC")!)
        zeroBacDate = createDate(2018, 1, 29, 13, 52, 5, timezone: TimeZone(abbreviation: "UTC")!)
        records = [
            RecordData(time: createDate(2018, 1, 26, 17, 5, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(time: createDate(2018, 1, 26, 17, 5, timezone: TimeZone(abbreviation: "UTC")!), bacLevel: 0.0),
            RecordData(
                time: createDate(2018, 1, 26, 17, 35, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 9.46236263736264
            ),
            RecordData(
                time: createDate(2018, 1, 26, 17, 35, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 9.46236263736264
            ),
            RecordData(time: DATE_NOW, bacLevel: 8.502362637362639),
            RecordData(
                time: createDate(2018, 1, 27, 1, 5, 27, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 8.33623763736264
            ),
            RecordData(
                time: createDate(2018, 1, 27, 1, 35, 27, timezone: TimeZone(abbreviation: "UTC")!),
                bacLevel: 9.041567307692308
            ),
            RecordData(time: zeroBacDate, bacLevel: 0.0)
        ]
        params.append(
            [
                session,
                absorptionDate,
                bacDuringAbsorption,
                maximumBacDate,
                bacWhenMaximum,
                duringEliminationDate,
                bacDuringElimination,
                afterEliminationDate,
                zeroBacDate,
                records
            ]
        )

        params.append(
            [
                Session(),
                createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!),
                0.0,
                createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!),
                0.0,
                createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!),
                0.0,
                createDate(2018, 1, 26, 13, 0, timezone: TimeZone(abbreviation: "UTC")!),
                DATE_NOW,
                [Record]()
            ]
        )
        
        return params
    }
}

// data
