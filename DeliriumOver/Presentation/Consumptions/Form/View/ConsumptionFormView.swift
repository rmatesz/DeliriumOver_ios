//
//  ConsumptionFormView.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

protocol ConsumptionFormView {
    func updateTime(_ time: Date)
    
    func showDrinkError(_ error: String)
    func hideDrinkError()
    
    var saveIsEnabled: Bool { get set }
}
