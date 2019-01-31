//
//  systemDateProvider.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 30..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

class SystemDateProvider: DateProvider {
    var currentDate: Date {
        get {
            return Date()
        }
    }
    
    public init() {}
}
