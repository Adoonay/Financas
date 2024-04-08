//
//  CategoryListViewModel.swift
//  Financas
//
//  Created by Adonay on 21/11/23.
//

import Foundation

protocol CategoryListViewModelProtocol {
    var categories: [Category] { get set }
    var state: Bindable<CategoryListState> { get set }

    func didTapAdd()
    func fetchList()
}

enum CategoryListState {
    case loading
    case empty
    case ready
}

class CategoryListViewModel {
    var service: FinancasServiceProtocol
    var coordinator: CategoryCoordinatorProtocol
    var categories: [Category] = []
    var state: Bindable<CategoryListState> = .init(.ready)

    init(service: FinancasServiceProtocol, coordinator: CategoryCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
    }
}

extension CategoryListViewModel: CategoryListViewModelProtocol {
    
    func fetchList() {
        state.value = .loading

        service.getCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                self.state.value = categories.isEmpty ? .empty : .ready
            case .failure(let failure):
                self.state.value = .empty
                print(failure)
            }
        }
    }

    func didTapAdd() {
        coordinator.presentAddCategory()
    }
}
