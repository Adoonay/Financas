//
//  TabBarController.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import UIKit

class TabBarController: UITabBarController, CodeView {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }

    func setupAppearance() {
        tabBar.tintColor = UIColor.systemMint

        let itemApperance = UITabBarItemAppearance()
        itemApperance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black,
        ]
        itemApperance.normal.iconColor = UIColor.black

        itemApperance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.systemMint]

        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.backgroundEffect = UIBlurEffect(style: .regular)
        appearance.stackedLayoutAppearance = itemApperance
        appearance.inlineLayoutAppearance = itemApperance

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        setNeedsStatusBarAppearanceUpdate()
    }

    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    func setupAdditionalConfiguration() {
        setupAppearance()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}
