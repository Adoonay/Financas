//
//  Category.swift
//  Financas
//
//  Created by Adonay on 06/03/24.
//

import Foundation
import FirebaseFirestore

struct Category: Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
}
