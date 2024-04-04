//
//  EntryCell.swift
//  Financas
//
//  Created by Adonay on 30/11/23.
//

import UIKit

class EntryCell: UITableViewCell, CodeView {
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 16
        view.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.alignment = .center
        return view
    }()

    lazy var iconView: IconView = {
        let view = IconView()
        view.type = .earning
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()

    lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12, weight: .semibold)
        view.textColor = .white
        view.backgroundColor = .gray
        return view
    }()

    lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.font = .systemFont(ofSize: 14, weight: .bold)
        return view
    }()

    lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.textColor = .gray
        view.font = .systemFont(ofSize: 12, weight: .regular)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    func configure(entry: Entry) {
        descriptionLabel.text = entry.description
        dateLabel.text = entry.date.formatted(format: "dd MMM")
        categoryLabel.text = " \(entry.category.name) "
        valueLabel.text = entry.value.currencyFormatted()
        valueLabel.textColor = entry.type.color
        iconView.tintColor = entry.type.color
        iconView.type = entry.type
    }

    func buildViewHierarchy() {
        contentView.addSubview(contentStack)

        contentStack.addArrangedSubview(iconView)
        contentStack.addArrangedSubview(.stack(views: [descriptionLabel, categoryLabel], axis: .vertical, spacing: 2, alignment: .leading))
        contentStack.addArrangedSubview(.stack(views: [valueLabel, dateLabel], axis: .vertical, spacing: 0))
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            categoryLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    func setupAdditionalConfiguration() {
        selectionStyle = .none

        categoryLabel.layer.cornerRadius = 4
        categoryLabel.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
