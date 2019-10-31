//
//  HasApply.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

protocol HasApply {
}

extension HasApply {
    func apply(closure:(Self) -> ()) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: HasApply { }
