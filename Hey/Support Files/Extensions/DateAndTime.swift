//
//  DateAndTime.swift
//  Ohana
//
//  Created by Mu Yu on 6/25/22.
//

import Foundation
import UIKit

struct DateAndTime: Codable {
    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var minute: Int
    var second: Int
}
extension DateAndTime {
    init() {
        let today = Date()
        self.year = today.year
        self.month = today.month
        self.day = today.dayOfMonth
        self.hour = today.hour
        self.minute = today.minute
        self.second = today.second
    }
    init(date: Date) {
        self.year = date.year
        self.month = date.month
        self.day = date.dayOfMonth
        self.hour = date.hour
        self.minute = date.minute
        self.second = date.second
    }
    init(date: DateTriple) {
        self.year = date.year
        self.month = date.month
        self.day = date.day
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
}
extension DateAndTime {
    func toDate(timeZone: String = "SGT") -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        dateComponents.timeZone = TimeZone(abbreviation: timeZone)
        return Calendar.current.date(from: dateComponents)
    }
    static func difference(from start: DateAndTime, to end: DateAndTime) -> TimeInterval {
        guard
            let startTime = start.toDate(),
            let endTime = end.toDate() else {
            return 0
        }
        return endTime - startTime
    }
}
extension DateAndTime {
    func beforeHours(_ numberOfHours: Int) -> DateAndTime {
        if let newDate = self.toDate()?.date(beforeHours: numberOfHours) {
            return DateAndTime(date: newDate)
        }
        return self
    }
    func afterHours(_ numberOfHours: Int) -> DateAndTime {
        if let newDate = self.toDate()?.date(afterHours: numberOfHours) {
            return DateAndTime(date: newDate)
        }
        return self
    }
    func beforeMinutes(_ numberOfMinutes: Int) -> DateAndTime {
        if let newDate = self.toDate()?.date(beforeMinutes: numberOfMinutes) {
            return DateAndTime(date: newDate)
        }
        return self
    }
    func afterMinutes(_ numberOfMinutes: Int) -> DateAndTime {
        if let newDate = self.toDate()?.date(afterMinutes: numberOfMinutes) {
            return DateAndTime(date: newDate)
        }
        return self
    }
}
