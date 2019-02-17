//
//  ConsumptionListView.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

protocol ConsumptionListView {
    func displayConsumptionList(consumptions: [ConsumptionListItem])
    func updateAddMenuItems(menuItems: [MenuItem])
}

struct MenuItem {
    var title: String
    var entity: Any?
}
