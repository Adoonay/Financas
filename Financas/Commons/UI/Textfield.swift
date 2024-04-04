//
//  Textfield.swift
//  Financas
//
//  Created by Adonay on 03/04/24.
//

import UIKit

protocol TextfieldDelegate: AnyObject {
    func didTextChanged(_ textfield: Textfield, value: String)
}

class Textfield: UIView, CodeView {
    weak var delegate: TextfieldDelegate?

    lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        return textfield
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 4
        return view
    }()

    enum Accessory {
        case none
        case icon(EntryType)
        case arrow
    }

    func configure(label: String, placeholder: String) {
        descriptionLabel.text = label
        textfield.placeholder = placeholder
    }

    func buildViewHierarchy() {
        addSubview(contentStack)

        contentStack.addArrangedSubview(descriptionLabel)
        contentStack.addArrangedSubview(textfield)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),

            textfield.heightAnchor.constraint(equalToConstant: 40),
            textfield.widthAnchor.constraint(equalTo: contentStack.widthAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        textfield.backgroundColor = .textfieldGray
        textfield.tintColor = .black
        textfield.layer.cornerRadius = 8.0

        textfield.leftView = UIView(frame: .init(x: 0, y: 0, width: 16, height: 40))
        textfield.leftViewMode = .always

        textfield.rightView = UIView(frame: .init(x: 0, y: 0, width: 16, height: 40))
        textfield.rightViewMode = .always

        textfield.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
    }

    func configure(accessory: Accessory) {
        switch accessory {
        case .none:
            textfield.leftView = UIView(frame: .init(x: 0, y: 0, width: 16, height: 40))
            textfield.rightView = UIView(frame: .init(x: 0, y: 0, width: 16, height: 40))
        case .icon(let entryType):
            textfield.leftView = TextfieldIconView(type: entryType)
            textfield.rightView = UIView(frame: .init(x: 0, y: 0, width: 16, height: 40))
        case .arrow:
            textfield.leftView = UIView(frame: .init(x: 0, y: 0, width: 16, height: 40))
            textfield.rightView = ArrowTextfieldIcon()
        }
    }

    @objc
    func didChangeText(_ textfield: UITextField) {
        delegate?.didTextChanged(self, value: textfield.text ?? "")
    }

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


