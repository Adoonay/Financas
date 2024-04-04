//
//  EntryListViewModel.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import Foundation

protocol EntryListViewModelProtocol {
    var state: Bindable<EntryListState> { get set }
    var entries: [Entry] { get set }

    func didTapAdd()
    func fetchList()
}

enum EntryListState {
    case loading
    case empty
    case ready
}

class EntryListViewModel {
    var service: FinancasServiceProtocol
    var coordinator: EntryCoordinatorProtocol
    var state: Bindable<EntryListState> = .init(.ready)
    var entries: [Entry] = []

    init(service: FinancasServiceProtocol, coordinator: EntryCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
    }
}

extension EntryListViewModel: EntryListViewModelProtocol {
    func fetchList() {
        self.state.value = .loading

        service.getEntries { result in
            switch result {
            case .success(let entries):
                self.entries = entries
                self.state.value = entries.isEmpty ? .empty : .ready
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func didTapAdd() {
        coordinator.continueToAddEntry()
    }
}
