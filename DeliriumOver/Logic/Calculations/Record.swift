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
    public var data: [RecordData]
}

public struct RecordData {
    public var time: Date
    public var bacLevel: Double
}
