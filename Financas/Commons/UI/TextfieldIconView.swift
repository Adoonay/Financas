//
//  TextfieldIconView.swift
//  Financas
//
//  Created by Adonay on 03/04/24.
//

import UIKit

class TextfieldIconView: UIView, CodeView {
    var type: EntryType = .earning {
        didSet {
            iconView.type = type
            backgroundView.backgroundColor = type.color
        }
    }

    lazy var iconView: IconView = {
        let view = IconView()
        view.type = .earning
        view.tintColor = .text
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(type: EntryType = .earning) {
        self.type = type
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        self.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundView)
        addSubview(iconView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            widthAnchor.constraint(equalToConstant: 48),

            backgroundView.widthAnchor.constraint(equalTo: heightAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),

            iconView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundView.backgroundColor = type.color
        iconView.type = type
    }
}
