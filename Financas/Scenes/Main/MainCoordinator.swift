//  
//  MainCoordinator.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    lazy var tabBarController: TabBarController = {
        let tabBarController = TabBarController()
        return tabBarController
    }()

    internal init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let entryNavigation = UINavigationController()
        let entryCoordinator = EntryCoordinator(navigationController: entryNavigation, delegate: self)
        entryCoordinator.start()
        childCoordinators.append(entryCoordinator)

        let categoryNavigation = UINavigationController()
        let categoryCoordinator = CategoryCoordinator(navigationController: categoryNavigation, delegate: self)
        categoryCoordinator.start()
        childCoordinators.append(categoryCoordinator)

        tabBarController.setViewControllers([entryNavigation, categoryNavigation], animated: false)

        navigationController.setViewControllers([tabBarController], animated: true)
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    
}

extension MainCoordinator: CategoryCoordinatorDelegate {

}

extension MainCoordinator: EntryCoordinatorDelegate {

}
