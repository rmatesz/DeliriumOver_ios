//
//  DateExtensions.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

public let ONE_HOUR_IN_SECONDS = 60 * 60
public let ONE_MINUTE_IN_MILLIS = 60 * 1000
public let ONE_HOUR_IN_MILLIS = 60 * ONE_MINUTE_IN_MILLIS

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
    
    return Calendar.current.date(from: dateComponents)!
}
