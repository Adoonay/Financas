//
//  EntryListViewModel.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import Foundation

protocol EntryListViewModelProtocol {
    func didTapAdd()
}

class EntryListViewModel {
    var coordinator: EntryCoordinatorProtocol

    init(coordinator: EntryCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension EntryListViewModel: EntryListViewModelProtocol {
    func didTapAdd() {
        coordinator.continueToAddEntry()
    }
}
