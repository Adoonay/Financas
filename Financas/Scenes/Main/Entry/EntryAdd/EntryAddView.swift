//
//  EntryAddView.swift
//  Financas
//
//  Created by Adonay on 03/04/24.
//

import UIKit

class EntryAddView: UIView, CodeView {
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
        view.configure(label: "Gasto", placeholder: "ex: Internet")
        return view
    }()

    lazy var valueTextfield: Textfield = {
        let view = Textfield()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(label: "Valor", placeholder: "R$ 0,00")
        view.configure(accessory: .icon(.earning))
        return view
    }()

    lazy var typeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var typeSegmentedControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insertSegment(withTitle: "Entrada", at: 0, animated: false)
        view.insertSegment(withTitle: "Saída", at: 1, animated: false)
        view.addTarget(self, action: #selector(updateType), for: .valueChanged)
        view.selectedSegmentIndex = 0
        return view
    }()

    lazy var categoryTextfield: Textfield = {
        let view = Textfield()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(label: "Categoria", placeholder: "Selecionar categoria")
        view.configure(accessory: .arrow)
        return view
    }()

    lazy var dateTextfield: Textfield = {
        let view = Textfield()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(label: "Data", placeholder: "Selecionar data")
        view.configure(accessory: .arrow)
        return view
    }()

    lazy var categoryPicker: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.preferredDatePickerStyle = .wheels
        view.datePickerMode = .date
        view.addTarget(self, action: #selector(updateDate), for: .valueChanged)
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

    var viewModel: EntryAddViewModelProtocol

    init(viewModel: EntryAddViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }

    func buildViewHierarchy() {
        addSubview(contentStack)

        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(fieldsStack)
        contentStack.addArrangedSubview(.stack(views: [actionButton, cancelButton], axis: .vertical, spacing: 8))

        fieldsStack.addArrangedSubview(nameTextfield)
        fieldsStack.addArrangedSubview(.stack(views: [typeDescriptionLabel, typeSegmentedControl], axis: .vertical, spacing: 4.0))
        fieldsStack.addArrangedSubview(valueTextfield)
        fieldsStack.addArrangedSubview(categoryTextfield)
        fieldsStack.addArrangedSubview(dateTextfield)

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

        titleLabel.text = "Adicionar lançamento"
        typeDescriptionLabel.text = "Tipo de lançamento"

        categoryTextfield.textfield.inputView = categoryPicker
        categoryTextfield.textfield.tintColor = .clear

        dateTextfield.textfield.inputView = datePicker
        dateTextfield.textfield.tintColor = .clear

        valueTextfield.textfield.keyboardType = .numberPad
        valueTextfield.textfield.addTarget(self, action: #selector(formatCurrency), for: .editingChanged)

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

    @objc
    func updateType() {
        let earnType: EntryType = typeSegmentedControl.selectedSegmentIndex == 0 ? .earning : .spent
        valueTextfield.configure(accessory: .icon(earnType))

        viewModel.update(type: earnType)
    }

    @objc
    func updateDate() {
        dateTextfield.textfield.text = datePicker.date.formatted()

        viewModel.update(date: datePicker.date)
    }

    @objc
    func formatCurrency(_ textfield: UITextField) {
        guard let text = textfield.text else {
            return
        }

        let numberValue = Int(text.onlyNumbers()) ?? 0
        let doubleValue = Double(numberValue) / 100.0

        textfield.text = doubleValue.currencyFormatted()
        viewModel.update(value: doubleValue)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EntryAddView: TextfieldDelegate {
    func didTextChanged(_ textfield: Textfield, value: String) {
        viewModel.update(description: value)
    }
}

extension EntryAddView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let category = viewModel.categories[row]
        return category.name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let category = viewModel.categories[row]

        viewModel.update(category: category)

        categoryTextfield.textfield.text = category.name
    }
}
