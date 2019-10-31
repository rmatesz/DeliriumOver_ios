//
//  DatePickerSheet.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 13..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class DatePickerSheet: UIView {
    @IBOutlet weak var datePicker: UIDatePicker!
    var onDateSelected: ((Date) -> ())?
    var onApplyClicked: (() -> ())?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 240))
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "DatePickerSheet" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    // MARK:- Button actions from .xib file
    
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
