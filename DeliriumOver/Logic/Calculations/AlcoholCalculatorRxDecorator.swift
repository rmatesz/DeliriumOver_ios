//
//  AlcoholCalculatorRxDecorator.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class AlcoholCalculatorRxDecorator {
    private let alcoholCalculator: AlcoholCalculator
    
    init(alcoholCalculator: AlcoholCalculator) {
        self.alcoholCalculator = alcoholCalculator
    }
    
    func calcTimeOfZeroBAC(session: Session) -> Single<Date> {
        return Single.deferred { () -> Single<Date> in
            return Single.just(self.alcoholCalculator.calcTimeOfZeroBAC(session))
        }
    }
    
    func calcBloodAlcoholConcentration(session: Session, date: Date) -> Single<Double> {
        return Single.deferred { () -> Single<Double> in
            return Single.just(self.alcoholCalculator.calcBloodAlcoholConcentration(session: session, date: date))
        }
    }
    
    func generateRecords(session: Session) -> Single<[Data]> {
        return Single.deferred { () -> Single<[Data]> in
            return Single.just(self.alcoholCalculator.generateRecords(session: session))
        }
    }
}
