//
//  Date.swift
//  Financas
//
//  Created by Adonay on 04/04/24.
//

import Foundation

extension Date {
    func formatted(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
