//
//  Extensions.swift
//  Homework
//
//  Created by Laura on 8/23/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import Foundation

extension String {
    func convertDate(to newPattern: String) -> String {
        var returnDate: String?
        let formatter = DateFormatter()
        let tempLocale = formatter.locale
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = newPattern
            formatter.locale = tempLocale
            returnDate = formatter.string(from: date)
        }
        return returnDate ?? ""
    }
}
