//  
//  CategoryAddViewModel.swift
//  Financas
//
//  Created by Adonay on 04/04/24.
//

import UIKit

class CategoryAddViewModel {
    var service: FinancasServiceProtocol
    var coordinator : CategoryCoordinatorProtocol
    var model: CategoryAddModel

    var isSaveEnabled: Bindable<Bool> = .init(false)

    init(service: FinancasServiceProtocol, coordinator: CategoryCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
        self.model = .init(name: "", description: "")
    }

    func didTapSave() {
        service.addCategory(model: model) { result in
            switch result {
            case .success:
                self.coordinator.dismissReloadList()
            case .failure(let failure):
                print("erro \(failure)")
            }
        }
    }

    func update(name: String) {
        model.name = name
        isSaveEnabled.value = model.isValid
    }

    func update(description: String) {
        model.description = description
        isSaveEnabled.value = model.isValid
    }
}
