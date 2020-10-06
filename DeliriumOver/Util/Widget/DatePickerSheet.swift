//
//  DatePickerSheet.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 13..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class DatePickerSheet: NumberPickerSheetBase {
    override var xibFilename: String { "DatePickerSheet" }

    @IBOutlet weak var datePicker: UIDatePicker!
    var onDateSelected: ((Date) -> Void)?
    var onApplyClicked: (() -> Void)?

    @IBAction func dateSelected(_ sender: Any) {
        onDateSelected?(datePicker.date)
    }

    @IBAction func nowClicked() {
        datePicker.setDate(Date(), animated: true)
    }

    @IBAction func applyClicked() {
        onDateSelected?(datePicker.date)
        onApplyClicked?()
    }
}
