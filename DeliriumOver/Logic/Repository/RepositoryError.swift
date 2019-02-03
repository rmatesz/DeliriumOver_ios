//
//  RepositoryError.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 03..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

class RepositoryError: Error {
    let message: String
    init(message: String) {
        self.message = message
    }
}
