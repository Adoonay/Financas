//
//  EntryType.swift
//  Financas
//
//  Created by Adonay on 30/11/23.
//

import UIKit

enum EntryType: String, Codable {
    case earning
    case spent

    var imageName: String {
        switch self {
        case .earning:
            return "arrow.down.circle.fill"
        case .spent:
            return "arrow.up.circle.fill"
        }
    }

    var color: UIColor {
        switch self {
        case .earning:
            return .earn
        case .spent:
            return .spent
        }
    }
}
