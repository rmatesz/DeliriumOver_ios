//
//  Session.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

public struct Session {
    var id: Int64 = 0
    var title: String = ""
    var description: String = ""
    var name: String = ""
    var weight: Double = 0.0
    var height: Double = 0.0
    var gender: Sex = Sex.MALE
    var consumptions: [Consumption] = []
    var inProgress: Bool = false
    var deviceId: String = ""
    var shared: Bool = false
    var shareKey: String = ""

    func clone() -> Session {
        var session = Session()
        session.name = name
        session.weight = weight
        session.height = height
        session.gender = gender
        session.deviceId = deviceId
        return session
    }
}
