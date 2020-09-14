//
//  DrinkRepository.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol DrinkRepository {
    func getFrequentlyConsumedDrinks() -> Observable<[Drink]>
    
    func getDrinks() -> Single<[Drink]>
}
