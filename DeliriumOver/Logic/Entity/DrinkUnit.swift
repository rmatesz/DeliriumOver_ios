//
//  DrinkUnit.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 30..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

enum DrinkUnit: Int, CaseIterable, CustomStringConvertible, Equatable {
    case centiliter = 10
    case deciliter = 100
    case liter = 1000
    
    func multiplier() -> Int {
        return rawValue
    }
    func label() -> String {
        switch self {
        case .centiliter: return "cl"
        case .deciliter: return "dl"
        case .liter: return "l"
        }
    }
    
    public var description: String { return label() }
    
    static func withLabel(_ label: String) -> DrinkUnit {
        return DrinkUnit.allCases
            .filter { (drinkUnit: DrinkUnit) -> Bool in
                drinkUnit.label() == label
            }
            .first
            ?? centiliter
    }
}
