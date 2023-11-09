//
//  EntryListViewController.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import UIKit

class EntryListViewController: UIViewController {
    var viewModel: EntryListViewModelProtocol

    init(viewModel: EntryListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .green

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAdd)))
    }

    @objc
    func handleAdd() {
        viewModel.didTapAdd()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
