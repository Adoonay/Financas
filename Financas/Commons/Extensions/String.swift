//
//  String.swift
//  Financas
//
//  Created by Adonay on 03/04/24.
//

import Foundation

extension String {
    func onlyNumbers() -> String {
        return self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }
}
