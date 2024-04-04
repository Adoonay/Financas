//  
//  EntryAddViewModel.swift
//  Financas
//
//  Created by Adonay on 03/04/24.
//

import UIKit

protocol EntryAddViewModelProtocol {
    var categories: [Category] { get set }

    func fetchCategories()
    func didTapSave()

    func update(description: String)
    func update(type: EntryType)
    func update(category: Category)
    func update(date: Date)
    func update(value: Double)
}

enum EntryAddViewState {
    case loading
    case ready
}

class EntryAddViewModel: EntryAddViewModelProtocol {
    var coordinator : EntryCoordinatorProtocol
    var service: FinancasServiceProtocol
    var model: Entry
    var categories: [Category] = []

    init(service: FinancasServiceProtocol, coordinator: EntryCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
        self.model = Entry.empty()
    }

    func fetchCategories() {
        service.getCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories.isEmpty ? [.init(id: "temp", name: "Sem categoria", description: "Indefino")] : categories
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func didTapSave() {
        service.addEntry(model: model) { result in
            switch result {
            case .success:
                self.coordinator.dismissReloadList()
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func update(description: String) {
        model.description = description
    }

    func update(type: EntryType) {
        model.type = type
    }

    func update(category: Category) {
        model.category = category
    }

    func update(date: Date) {
        model.date = date
    }

    func update(value: Double) {
        model.value = value
    }
}
