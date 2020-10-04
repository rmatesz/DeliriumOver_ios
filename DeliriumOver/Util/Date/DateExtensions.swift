//
//  DateExtensions.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

public let kOneMinuteInMillis = 60 * 1000
public let kOneHourInMinutes = 60
public let kOneMinuteInSeconds = 60
public let kOneHourInMillis = kOneHourInMinutes * kOneMinuteInMillis
public let kOneHourInSeconds = kOneHourInMinutes * kOneMinuteInSeconds

func createDate(
    _ year: Int,
    _ month: Int,
    _ day: Int,
    _ hour: Int = 0,
    _ minute: Int = 0,
    _ seconds: Int = 0,
    timezone: TimeZone = TimeZone.current
    ) -> Date {
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    dateComponents.hour = hour
    dateComponents.minute = minute
    dateComponents.second = seconds
    dateComponents.timeZone = timezone
    let date = Calendar.current.date(from: dateComponents)!
    return date
}
