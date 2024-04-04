//
//  CategoryCell.swift
//  Financas
//
//  Created by Adonay on 06/03/24.
//

import UIKit

class CategoryCell: UITableViewCell, CodeView {
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()

    lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textColor = .black
        return view
    }()

    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textColor = .black
        return view
    }()

    func configure(category: Category) {
        categoryLabel.text = category.name
        descriptionLabel.text = category.description
    }

    func buildViewHierarchy() {
        contentView.addSubview(contentStack)

        contentStack.addArrangedSubview(categoryLabel)
        contentStack.addArrangedSubview(descriptionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func setupAdditionalConfiguration() {

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
