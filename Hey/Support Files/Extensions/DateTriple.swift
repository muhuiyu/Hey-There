//
//  DateTriple.swift
//  Get Fit
//
//  Created by Mu Yu on 8/31/22.
//

import Foundation
import UIKit

struct DateTriple: Comparable, Hashable, Codable {
    var year: Int
    var month: Int
    var day: Int
}
extension DateTriple {
    static func < (lhs: DateTriple, rhs: DateTriple) -> Bool {
        guard let ldate = lhs.toDate(), let rdate = rhs.toDate() else { return false }
        return ldate < rdate
    }
}
extension DateTriple {
    func toDate(timeZone: String = "SGT") -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: timeZone)
        return Calendar.current.date(from: dateComponents)
    }
}
