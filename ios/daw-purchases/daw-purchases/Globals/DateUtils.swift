//
//  DateUtils.swift
//  ami-ios-base
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import UIKit

public class DateUtils: NSObject {
    public static let locale = "vi-VN"
   public static let dateFormatter = "yyyy-MM-dd HH:mm:ss.fff"
    public static func dateFrom(string text:String, dateFormat: String = dateFormatter, timeZone: TimeZone? = nil, calendar: Calendar = Calendar(identifier: .gregorian), locale: Locale = Locale(identifier: locale)) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        }
        dateFormatter.calendar = calendar
        dateFormatter.locale = locale
        
        guard let date = dateFormatter.date(from: text) else {
            return nil
        }
        return date
    }
    
    public static func getDateComponent(date: Date, components:[Calendar.Component] = [.year, .month, .day, .hour, .minute, .second], calendar: Calendar = Calendar(identifier: .gregorian)) -> [Calendar.Component : Int] {
        var dateComponents = [Calendar.Component : Int]()
        for comp in components {
            dateComponents[comp] = calendar.component(comp, from: date)
        }
        
        return dateComponents
    }
    
    public static func dateString(date:Date, dateFormat: String, timeZone: TimeZone? = nil, calendar: Calendar = Calendar(identifier: .gregorian), locale: Locale = Locale(identifier: locale)) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        }
        dateFormatter.calendar = calendar
        dateFormatter.locale = locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public static func interval(fromDate: Date, toDate: Date, by dateFormat: String, timeZone: TimeZone? = nil, calendar: Calendar = Calendar(identifier: .gregorian), locale: Locale = Locale(identifier: locale)) -> TimeInterval {
        let fromDateString = DateUtils.dateString(date: fromDate, dateFormat: dateFormat, timeZone: timeZone, calendar: calendar, locale: locale)
        let toDateString = DateUtils.dateString(date: toDate, dateFormat: dateFormat, timeZone: timeZone, calendar: calendar, locale: locale)
        
        if let fromDateFormatted = DateUtils.dateFrom(string: fromDateString, dateFormat: dateFormat, timeZone: timeZone, calendar: calendar, locale: locale) {
            if let toDateFormatted = DateUtils.dateFrom(string: toDateString, dateFormat: dateFormat, timeZone: timeZone, calendar: calendar, locale: locale) {
                return toDateFormatted.timeIntervalSince(fromDateFormatted)
            }
        }
        
        return 0
    }
}
