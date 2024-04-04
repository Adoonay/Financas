//  
//  EntryAddViewController.swift
//  Financas
//
//  Created by Adonay on 03/04/24.
//

import UIKit

class EntryAddViewController: UIViewController {
    var viewModel: EntryAddViewModelProtocol

    lazy var contentView: EntryAddView = {
        let view = EntryAddView(viewModel: viewModel)
        return view
    }()

    init(viewModel: EntryAddViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        viewModel.fetchCategories()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
