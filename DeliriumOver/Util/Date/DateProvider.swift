//
//  DateProvider.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 30..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

var dateProvider: DateProvider = SystemDateProvider()
var currentDate: Date {
    get {
        return dateProvider.currentDate
    }
}
public protocol DateProvider {
    var currentDate: Date { get }
}
