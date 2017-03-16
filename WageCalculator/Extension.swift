//
//  Extension.swift
//  WageCalculator
//
//  Created by Hana  Demas on 3/12/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation

//String extention to get date from string
extension String {
    func toDateString (inputFormat: String ) -> Date? {
        let dateFormatter = setupDateFormatter(inputFormat: inputFormat)
        return dateFormatter.date(from: self)
    }
}
//DATE extention
extension Date {
    //to get double hours from date object
    func doubleHours() ->Double {
        let hours = Calendar.current.component(.hour, from: self)
        let minutes = Calendar.current.component(.minute, from: self)
        let doubleHour:Double = Double(hours) + Double(minutes)/60
        return round(doubleHour * 100)/100
    }
    
    //to get String from date
    func stringFromDate(inputFormat: String ) -> String? {
        let dateFormatter = setupDateFormatter(inputFormat: inputFormat)
        return dateFormatter.string(from: self)
    }
}
//function to setup dateformatter
func setupDateFormatter(inputFormat: String )->DateFormatter{
    TimeZone.ReferenceType.default = TimeZone(abbreviation: "UTC+2:00")!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputFormat
    dateFormatter.timeZone = TimeZone.ReferenceType.default
    dateFormatter.locale = Locale.init(identifier: "en_GB")
    return dateFormatter
}
