//
//  QuantityPickerSheet.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 16..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class QuantityPickerSheet<Unit: CustomStringConvertible>: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var numberPicker: UIPickerView!
    var onQuantitySelected: ((Double, Unit) -> ())?
    var onApplyClicked: (() -> ())?
    var minimum: Double = 0.0
    var maximum: Double = 100.0
    var step: Double = 0.1
    var unit: [Unit] = []
    
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
        let xibFileName = "QuantityPickerSheet" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return unit.isEmpty ? 1 : 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return Int((maximum - minimum) / step) + 1
        } else {
            return unit.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return String(format:"%.1f", minimum + step * Double(row))
        } else {
            return unit[row].description
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        notifyQuantitySelected()
    }
    
    @IBAction func onApplyBtnClicked() {
        notifyQuantitySelected()
        onApplyClicked?()
    }
    
    private func notifyQuantitySelected() {
        let quantity = minimum + Double(numberPicker.selectedRow(inComponent: 0)) * step
        let unit = self.unit[numberPicker.selectedRow(inComponent: 1)]
        onQuantitySelected?(quantity, unit)
    }
}


