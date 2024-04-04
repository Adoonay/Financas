//  
//  CategoryAddViewController.swift
//  Financas
//
//  Created by Adonay on 04/04/24.
//

import UIKit

class CategoryAddViewController: UIViewController {
    var viewModel: CategoryAddViewModel

    lazy var contentView: CategoryAddView = {
        return CategoryAddView(viewModel: viewModel)
    }()

    init(viewModel: CategoryAddViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
