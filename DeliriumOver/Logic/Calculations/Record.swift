//
//  Record.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

public struct Record {
    public var name: String
    public var data: [Data]
}

public struct Data {
    public var time: Date
    public var bacLevel: Double
}
