//
//  String+Extension.swift
//  DemoAPIProject
//
//  Created by Raj Saija on 15/04/23.
//

import Foundation


extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
