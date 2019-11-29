//
//  CalculationsSwinject.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class CalculationsSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.register(AlcoholCalculator.self) { (resolver) -> AlcoholCalculator in
            AlcoholCalculator()
        }

        defaultContainer.register(AlcoholCalculatorRxDecorator.self) { (resolver) -> AlcoholCalculatorRxDecorator in
            AlcoholCalculatorRxDecorator(alcoholCalculator: resolver.resolve(AlcoholCalculator.self)!)
        }
    }
}
