//  
//  CodeView.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import Foundation

protocol BindableView {
    func bindViewModel()
}

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {
        
    }
}

extension CodeView where Self : BindableView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
        bindViewModel()
    }
}
