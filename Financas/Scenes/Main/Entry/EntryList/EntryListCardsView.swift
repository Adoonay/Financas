//
//  EntryListCardsView.swift
//  Financas
//
//  Created by Adonay on 29/11/23.
//

import UIKit

class EntryListCardsView: UIStackView, CodeView {
    lazy var inView: CardView = {
        let view = CardView()
        view.configure(value: "R$ 3000,00", subtitle: "Entradas esse mês", type: .earning)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var outView: CardView = {
        let view = CardView()
        view.configure(value: "R$ 250,00", subtitle: "Saídas esse mês", type: .spent)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addArrangedSubview(inView)
        addArrangedSubview(outView)
    }

    func setupConstraints() {

    }

    func setupAdditionalConfiguration() {
        axis = .horizontal
        distribution = .fillEqually
        spacing = 16
    }
}


