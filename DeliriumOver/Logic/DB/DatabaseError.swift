//
//  DatabaseError.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 01..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation

class DatabaseError: Error {
    let message: String
    init(message: String) {
        self.message = message
    }
}

