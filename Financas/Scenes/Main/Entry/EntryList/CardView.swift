//
//  CardView.swift
//  Financas
//
//  Created by Adonay on 29/11/23.
//

import UIKit

class CardView: UIView, CodeView {
    lazy var iconView: IconView = {
        let view = IconView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .darkGray
        return view
    }()

    lazy var textStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()

    lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 26, weight: .bold)
        view.minimumScaleFactor = 0.5
        view.adjustsFontSizeToFitWidth = true
        view.textColor = .darkGray
        return view
    }()

    lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.numberOfLines = 0
        view.textColor = .gray
        return view
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    func configure(value: String, subtitle: String, type: EntryType) {
        valueLabel.text = value
        subtitleLabel.text = subtitle
        iconView.type = type
        backgroundColor = type.color
    }

    func buildViewHierarchy() {
        addSubview(iconView)
        addSubview(textStack)

        textStack.addArrangedSubview(valueLabel)
        textStack.addArrangedSubview(subtitleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 20),
            textStack.leadingAnchor.constraint(equalTo: iconView.leadingAnchor),
            textStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            textStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }

    func setupAdditionalConfiguration() {
        layer.cornerRadius = 8
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
