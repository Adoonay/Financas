//
//  CategoryListViewController.swift
//  Financas
//
//  Created by Adonay on 21/11/23.
//

import UIKit

class CategoryListViewController: UIViewController, CodeView, BindableView {
    var viewModel: CategoryListViewModelProtocol

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()

    init(viewModel: CategoryListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @objc
    func handleAdd() {
        viewModel.didTapAdd()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()

        viewModel.fetchList()
    }

    func bindViewModel() {
        viewModel.state.bind { state in
            self.setup(state: state)
        }
    }

    func setup(state: CategoryListState) {
        switch state {
        case .loading:
            tableView.isHidden = true
        case .empty:
            tableView.isHidden = true
        case .ready:
            tableView.isHidden = false
            tableView.reloadData()
        }
    }

    func setupTableView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "\(CategoryCell.self)")
    }

    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        navigationItem.title = "Categorias"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                                                            style: .plain, target: self, action: #selector(handleAdd))
        view.backgroundColor = .white
        setupNavigation()
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CategoryCell.self)", for: indexPath)
        let category = viewModel.categories[indexPath.row]
        if let cell = cell as? CategoryCell {
            cell.configure(category: category)
        }
        return cell
    }
}
