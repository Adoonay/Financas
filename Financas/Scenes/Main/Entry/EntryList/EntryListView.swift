//
//  EntryListView.swift
//  Financas
//
//  Created by Adonay on 29/11/23.
//

import UIKit

class EntryListView: UIView, CodeView {
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .center
        return view
    }()

    lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insertSegment(withTitle: "Essa semana", at: 0, animated: false)
        view.insertSegment(withTitle: "Essa mês", at: 1, animated: false)
        view.insertSegment(withTitle: "Todos", at: 2, animated: false)
        view.selectedSegmentIndex = 0
        return view
    }()

    lazy var cardsHeader: EntryListCardsView = {
        let view = EntryListCardsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()

    var viewModel: EntryListViewModelProtocol

    init(viewModel: EntryListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.state.bind { state in
            self.setup(state: state)
        }
    }

    func setup(state: EntryListState) {
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

    func buildViewHierarchy() {
        addSubview(contentStack)

        contentStack.addArrangedSubview(segmentedControl)
        contentStack.addArrangedSubview(cardsHeader)
        contentStack.addArrangedSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            segmentedControl.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
            cardsHeader.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
        tableView.register(EntryCell.self, forCellReuseIdentifier: "\(EntryCell.self)")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EntryListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(EntryCell.self)", for: indexPath)
        let entry = viewModel.entries[indexPath.row]
        if let cell = cell as? EntryCell {
            cell.configure(entry: entry)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.entries.count
    }
}
