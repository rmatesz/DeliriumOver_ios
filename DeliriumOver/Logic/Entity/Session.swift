//
//  Session.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

public struct Session {
    var id: String = ""
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

    init(sessionEntity: SessionEntity) {
        self.id = sessionEntity.objectID.uriRepresentation().absoluteString
        self.title = sessionEntity.title ?? self.title
        self.description = sessionEntity.desc ?? self.description
        self.name = sessionEntity.name ?? self.name
        self.weight = sessionEntity.weight
        self.gender = Sex(rawValue: Int(sessionEntity.gender)) ?? self.gender
        self.consumptions = sessionEntity.consumptions?.allObjects.map({ (any) -> Consumption in
            Consumption(consumptionEntity: (any as! ConsumptionEntity))
        }) ?? []
    }
    
    init(
        id: String = "",
        title: String = "",
        description: String = "",
        name: String = "",
        weight: Double = 0.0,
        height: Double = 0.0,
        gender: Sex = Sex.MALE,
        consumptions: [Consumption] = [],
        inProgress: Bool = false,
        deviceId: String = "",
        shared: Bool = false,
        shareKey: String = ""
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.name = name
        self.weight = weight
        self.gender = gender
        self.consumptions = consumptions
        self.inProgress = inProgress
        self.deviceId = deviceId
        self.shared = shared
        self.shareKey = shareKey
    }

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
