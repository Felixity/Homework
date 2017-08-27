//
//  Extensions.swift
//  Homework
//
//  Created by Laura on 8/23/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit

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

extension UIColor {
    
    static let textViewColor = UIColor.init(fromHexString: "#c7c7cdff")
    
    public convenience init?(fromHexString: String) {
        
        let r, g, b, a: CGFloat
        
        if fromHexString.hasPrefix("#") {
            let start = fromHexString.characters.index(fromHexString.startIndex, offsetBy: 1)
            let hexColor = fromHexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8 ) / 255
                    a = CGFloat((hexNumber & 0x000000ff)      ) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
