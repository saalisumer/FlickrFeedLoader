//
//  Date+Formatter.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 09/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
extension Date {
    static func getFormattedDate(string: String , fromFormatter:String, toFormatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = fromFormatter
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = toFormatter
        let date: Date? = dateFormatterGet.date(from: string)
        return dateFormatterPrint.string(from: date!);
    }
}
