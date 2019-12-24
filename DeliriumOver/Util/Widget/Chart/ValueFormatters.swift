//
//  ValueFormatters.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2019. 12. 24..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Charts

class ThousandthsValueFormatter : IValueFormatter {
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        return String.init(format: "%.2f ‰", value)
    }
}

class DateAxisValueFormatter : IAxisValueFormatter {
    
    private let formatString: String
    
    init (formatString: String) {
        self.formatString = formatString
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return DateFormatter().apply { $0.dateFormat = formatString }.string(from: date)
    }
}
