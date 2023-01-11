//
//  TimeInterval+Extensions.swift
//  Ohana
//
//  Created by Mu Yu on 6/27/22.
//

import Foundation

extension TimeInterval {
    func toFullTimeString(unitsStyle: DateComponentsFormatter.UnitsStyle = .positional) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = unitsStyle
        return formatter.string(from: self) ?? ""
    }
    func toHourMinuteString(unitsStyle: DateComponentsFormatter.UnitsStyle = .positional) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = unitsStyle
        return formatter.string(from: self) ?? ""
    }
    func toMinuteString(unitsStyle: DateComponentsFormatter.UnitsStyle = .positional) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute]
        formatter.unitsStyle = unitsStyle
        return formatter.string(from: self) ?? ""
    }
}
extension TimeInterval {
    var hourMinuteSecondMS: String {
        String(format:"%d:%02d:%02d.%03d", hour, minute, second, millisecond)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        if hour > 0 {
            return Int((self/60).truncatingRemainder(dividingBy: 60)) + hour * 60
        } else {
            return Int((self/60).truncatingRemainder(dividingBy: 60))
        }
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}
