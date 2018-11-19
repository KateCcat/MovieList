//
//  NSDateFormatter.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 11/11/2017.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import UIKit

extension DateFormatter {

    static let networkDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    static func date(jsonString: String?) -> Date? {
        if let jsonString = jsonString {
            return DateFormatter.networkDateFormatter.date(from: jsonString)
        }
        return nil
    }

    static let tableDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    static func tableDateString(from date: Date?) -> String? {
        if let date = date {
            return DateFormatter.tableDateFormatter.string(from: date)
        }
        return nil
    }
}
