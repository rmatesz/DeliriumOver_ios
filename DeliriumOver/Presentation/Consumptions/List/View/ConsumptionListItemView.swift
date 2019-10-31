//
//  ConsumptionListItemView.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

public class ConsumptionListItemView : UITableViewCell {
    private static let dateFormatter = DateFormatter().apply { $0.dateFormat = "HH:mm" }
    // MARK: Properties
    @IBOutlet private weak var drink: UILabel!
    @IBOutlet private weak var quantity: UILabel!
    @IBOutlet private weak var date: UILabel!
    
    func update(consumption: ConsumptionListItem) {
        drink.text = "\(consumption.drink) (\(consumption.alcohol))"
        quantity.text = consumption.quantity
        date.text = ConsumptionListItemView.dateFormatter.string(from: consumption.date)
    }
}
