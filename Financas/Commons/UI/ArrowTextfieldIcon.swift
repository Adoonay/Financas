//
//  ArrowTextfieldIcon.swift
//  Financas
//
//  Created by Adonay on 03/04/24.
//

import UIKit

class ArrowTextfieldIcon: UIView, CodeView {
    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.down")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        self.translatesAutoresizingMaskIntoConstraints = false

        addSubview(iconView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            widthAnchor.constraint(equalToConstant: 40),

            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
