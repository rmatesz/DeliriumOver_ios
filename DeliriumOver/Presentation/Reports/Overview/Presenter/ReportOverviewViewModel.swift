//
//  ReportOverviewPresenter.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxCocoa

protocol ReportOverviewViewModel {
    var bacLevel: BehaviorRelay<Float> { get }
    var alcoholEliminationDate: BehaviorRelay<Date> { get }
    var sessionTitle: BehaviorRelay<String> { get }
    var chartData: BehaviorRelay<[Record]> { get }

    func onTitleEdited(title: String)
}
