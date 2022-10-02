//
//  Date+convertDateInString.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import Foundation

extension Date {
    func convertDateInString(_ dateFormate: String = L10n.Picker.dateFormate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormate
        formatter.locale = AppConfiguration.locale
        return formatter.string(from: self)
    }
}
