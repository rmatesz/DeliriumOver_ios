//
//  ConsumptionFormView.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

protocol ConsumptionFormView {
    func updateTime(_ time: Date)
    
    func showDrinkError(_ error: String)
    func hideDrinkError()

    func showAlert(title: String, message: String, action: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()

    var saveIsEnabled: Bool { get set }
}
