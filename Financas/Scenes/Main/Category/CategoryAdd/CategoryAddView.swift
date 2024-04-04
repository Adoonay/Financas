//
//  CategoryAddView.swift
//  Financas
//
//  Created by Adonay on 04/04/24.
//

import UIKit

class CategoryAddView: UIView, CodeView {
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 36
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 28, weight: .bold)
        view.textColor = .black
        return view
    }()

    lazy var fieldsStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 18
        return view
    }()

    lazy var nameTextfield: Textfield = {
        let view = Textfield()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.configure(label: "Nome da categoria", placeholder: "ex: Casa")
        return view
    }()

    lazy var descriptionTextfield: Textfield = {
        let view = Textfield()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.configure(label: "Descrição da categoria", placeholder: "ex: Gastos relacionados a moradia...")
        return view
    }()

    lazy var actionButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("SALVAR", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 8.0
        view.isEnabled = false
        return view
    }()

    lazy var cancelButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("CANCELAR", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        view.setTitleColor(.systemMint, for: .normal)
        return view
    }()

    var viewModel: CategoryAddViewModel

    init(viewModel: CategoryAddViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        bindViewModel()
        update(isEnabled: false)
    }

    func bindViewModel() {
        viewModel.isSaveEnabled.bind { isEnabled in
            self.update(isEnabled: isEnabled)
        }
    }

    func update(isEnabled: Bool) {
        self.actionButton.isEnabled = isEnabled
        self.actionButton.alpha = isEnabled ? 1.0 : 0.6
    }

    func buildViewHierarchy() {
        addSubview(contentStack)

        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(fieldsStack)
        contentStack.addArrangedSubview(.stack(views: [actionButton, cancelButton], axis: .vertical, spacing: 8))

        fieldsStack.addArrangedSubview(nameTextfield)
        fieldsStack.addArrangedSubview(descriptionTextfield)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),

            actionButton.heightAnchor.constraint(equalToConstant: 52),
            cancelButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white

        titleLabel.text = "Adicionar categoria"

        actionButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
    }

    @objc
    func handleSave() {
        viewModel.didTapSave()
    }

    @objc
    func handleCancel() {

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryAddView: TextfieldDelegate {
    func didTextChanged(_ textfield: Textfield, value: String) {
        switch textfield {
        case nameTextfield:
            viewModel.update(name: value)
        case descriptionTextfield:
            viewModel.update(description: value)
        default:
            break
        }
    }
}
