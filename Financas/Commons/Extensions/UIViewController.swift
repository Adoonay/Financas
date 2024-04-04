//
//  UIViewController.swift
//  Financas
//
//  Created by Adonay on 21/11/23.
//

import UIKit

extension UIViewController {
    func setupNavigation() {
        self.navigationController?.navigationBar.tintColor = .systemMint
        self.navigationItem.largeTitleDisplayMode = .always

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil

        let itemAppearence = UIBarButtonItemAppearance(style: .plain)
        itemAppearence.normal.titleTextAttributes = [.foregroundColor: UIColor.systemMint]

        appearance.buttonAppearance = itemAppearence
        appearance.backButtonAppearance = itemAppearence
        appearance.doneButtonAppearance = itemAppearence

        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UINavigationController {
    func getViewController<T: UIViewController>(type: T.Type) -> T? {
        return viewControllers.first(where: { $0 is T }) as? T
    }
}
