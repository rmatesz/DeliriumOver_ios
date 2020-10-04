//
//  ReportOverviewInteractor.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol ReportOverviewInteractor {
    func loadSession() -> Observable<Session>
    func loadStatistics() -> Observable<Statistics>
    func loadRecords() -> Observable<[Record]>
    func loadFrequentlyConsumedDrinks() -> Observable<[Drink]>
    func saveSession(session: Session) -> Completable
    func add(drink: Drink) -> Completable
}
