//
//  Date+Formatting.swift
//  ResMedResults
//
//  Created by matt rooney on 27/02/2022.
//

import Foundation

extension Date {
    
    static func formatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm:ss a"
        return dateFormatter
    }
    
}
