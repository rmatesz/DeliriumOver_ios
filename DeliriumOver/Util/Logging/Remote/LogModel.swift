//
//  LogModel.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 08..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation

struct LogModel: Codable {
    let timestamp: Double
    let category: String?
    let level: LogLevel
    let message: String?
    let error: String?
}
