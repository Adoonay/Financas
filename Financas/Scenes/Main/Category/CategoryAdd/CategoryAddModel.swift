//  
//  CategoryAddModel.swift
//  Financas
//
//  Created by Adonay on 04/04/24.
//

import UIKit

struct CategoryAddModel {
    var name: String
    var description: String

    var isValid: Bool {
        return !name.isEmpty && !description.isEmpty
    }
}
