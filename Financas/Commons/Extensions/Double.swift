//
//  Double.swift
//  Financas
//
//  Created by Adonay on 03/04/24.
//

import Foundation

extension Double {
    func currencyFormatted() -> String {
        let formatter = NumberFormatter()
        formatter.locale = .init(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.currencySymbol = "R$"
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
