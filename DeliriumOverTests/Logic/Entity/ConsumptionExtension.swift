//
//  ConsumptionExtension.swift
//  DeliriumOverTests
//
//  Created by Mate on 2019. 02. 12..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Cuckoo
@testable import DeliriumOver

extension Consumption : Equatable, Matchable {
    public var matcher: ParameterMatcher<Consumption> {
        return ParameterMatcher { tested in
            self == tested
        }
    }
    
    public typealias MatchedType = Consumption
    
    public static func == (left: Consumption, right: Consumption) -> Bool {
        return left.id == right.id && left.drink == right.drink && left.quantity == right.quantity && left.unit.rawValue == right.unit.rawValue && left.alcohol == right.alcohol && left.date == right.date
    }
}
