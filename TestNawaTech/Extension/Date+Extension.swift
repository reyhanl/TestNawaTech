//
//  Date+Extension.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import Foundation

extension Date{
    static var defaultDateFormat = "dd/MM/yyyy"
    static var monthsName: [String] = [
        "January", "February", "March", "April", "May", "June", "July", "August",
        "September", "October", "November", "Desember"
    ]
    
    func getString(format: String) -> String{
        let date = Date()

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = format

        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

}
