//
//  EntryListViewController.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import UIKit

class EntryListViewController: UIViewController, CodeView {
    var viewModel: EntryListViewModelProtocol

    lazy var contentView: EntryListView = {
        let view = EntryListView(viewModel: viewModel)
        return view
    }()

    init(viewModel: EntryListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        viewModel.fetchList()
    }

    @objc
    func handleAdd() {
        viewModel.didTapAdd()
    }

    func setupAdditionalConfiguration() {
        navigationItem.title = "Lançamentos"
        setupNavigation()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), 
                                                            style: .plain, target: self, action: #selector(handleAdd))
    }

    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
