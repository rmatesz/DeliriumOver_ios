//
//  DrinkExtension.swift
//  DeliriumOverTests
//
//  Created by Mate on 2019. 02. 15..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Cuckoo
@testable import DeliriumOver

class DrinkArray : Equatable {
    let data: [Drink]
    
    init(_ data: [Drink]) {
        self.data = data
    }
    
    public static func == (lhs: DrinkArray, rhs: DrinkArray) -> Bool {
        if (lhs.data.count != rhs.data.count) {
            return false
        }
        
        for (left, right) in zip(lhs.data, rhs.data) {
            if left != right {
                return false
            } 
        }
        
        return true
    }
    
    
}

extension Drink : Equatable, Matchable {
    public var matcher: ParameterMatcher<Drink> {
        return ParameterMatcher { tested in
            self == tested
        }
    }
    
    public typealias MatchedType = Drink
    
    public static func == (left: Drink, right: Drink) -> Bool {
        return left.id == right.id && left.name == right.name && left.alcohol == right.alcohol && left.defaultUnit == right.defaultUnit && left.defaultQuantity == right.defaultQuantity && left.drinkType == right.drinkType && left.localization == right.localization
    }
}
