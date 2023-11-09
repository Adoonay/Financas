//  
//  CategoryCoordinator.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import UIKit

class CategoryCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var delegate: CategoryCoordinatorDelegate?
    
    internal init(navigationController: UINavigationController, delegate: CategoryCoordinatorDelegate?) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    func start() {
        let viewController2 = UIViewController()
        viewController2.tabBarItem = .init(title: "Categorias", image: UIImage(systemName: "list.bullet.rectangle"), selectedImage: UIImage(systemName: "list.bullet.rectangle.fill"))
        viewController2.tabBarItem.tag = 1
        viewController2.view.backgroundColor = .yellow

        navigationController.setViewControllers([viewController2], animated: true)
    }
}

extension CategoryCoordinator: CategoryCoordinatorProtocol {
    
}
