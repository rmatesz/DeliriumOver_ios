//
//  DrinkUnit.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 30..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

enum DrinkUnit: Int, CaseIterable, CustomStringConvertible, Equatable {
    case CL = 10
    case DL = 100
    case L = 1000
    
    func multiplier() -> Int {
        return rawValue
    }
    func label() -> String {
        switch self {
        case .CL: return "cl"
        case .DL: return "dl"
        case .L: return "l"
        }
    }
    
    public var description: String { return label() }
    
    static func withLabel(_ label: String) -> DrinkUnit {
        return DrinkUnit.allCases
            .filter { (drinkUnit: DrinkUnit) -> Bool in
                drinkUnit.label() == label
            }
            .first
            ?? CL
    }
}
