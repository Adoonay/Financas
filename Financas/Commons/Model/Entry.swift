//
//  Entry.swift
//  Financas
//
//  Created by Adonay on 30/11/23.
//

import Foundation
import FirebaseFirestore

struct Entry: Codable {
    @DocumentID var id: String?
    var description: String
    var type: EntryType
    var category: Category
    var date: Date
    var value: Double

    static func empty() -> Entry {
        return .init(id: UUID().uuidString, description: "", type: .earning, category: .init(id: "", name: "", description: ""), date: Date(), value: 0.0)
    }
}
