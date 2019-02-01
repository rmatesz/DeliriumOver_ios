//
//  TestDateProvider.swift
//  DeliriumOverTests
//
//  Created by Mate on 2019. 02. 01..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
@testable import DeliriumOver

class TestDateProvider: DateProvider {
    let currentDate: Date
    
    public init(date: Date) {
        currentDate = date
    }
}
