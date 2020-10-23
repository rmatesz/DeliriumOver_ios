//
//  ConsumptionListItemView.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 09. 28..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import XCTest
import UIKit
@testable import DeliriumOver

class ConsumptionListItemViewTests: XCTestCase {
    private let drink = "Beer"
    private let alcohol = "5.3 %"
    private let quantity = "5.0 dl"
    private let hour = 10
    private let minute = 32
    private lazy var date = createDate(2020, 9, 29, hour, minute)
    private lazy var item = ConsumptionListItem(drink: drink, alcohol: alcohol, quantity: quantity, date: date, consumption:  Consumption())
    private let underTest = ConsumptionListItemView()

    func testUpdatePopulatesLabelsText() {
        let drinkLabel = UILabel()
        let quantityLabel = UILabel()
        let dateLabel = UILabel()
        underTest.drink = drinkLabel
        underTest.quantity = quantityLabel
        underTest.date = dateLabel
        underTest.update(consumption: item)

        XCTAssertEqual("\(drink) (\(alcohol))", underTest.drink.text)
        XCTAssertEqual(quantity, underTest.quantity.text)
        XCTAssertEqual("\(hour):\(minute)", underTest.date.text)
    }
}
