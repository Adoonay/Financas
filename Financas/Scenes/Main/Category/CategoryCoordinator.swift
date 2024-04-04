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
    var service: FinancasServiceProtocol

    weak var delegate: CategoryCoordinatorDelegate?
    
    internal init(navigationController: UINavigationController, 
                  service: FinancasServiceProtocol,
                  delegate: CategoryCoordinatorDelegate?) {
        self.navigationController = navigationController
        self.service = service
        self.delegate = delegate
    }
    
    func start() {
        let viewModel = CategoryListViewModel(service: service, coordinator: self)
        let viewController = CategoryListViewController(viewModel: viewModel)
        viewController.tabBarItem = .init(title: "Categorias", image: UIImage(systemName: "list.bullet.rectangle"), selectedImage: UIImage(systemName: "list.bullet.rectangle.fill"))
        viewController.tabBarItem.tag = 1

        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([viewController], animated: true)
    }
}

extension CategoryCoordinator: CategoryCoordinatorProtocol {
    func presentAddCategory() {
        let viewModel = CategoryAddViewModel(service: service, coordinator: self)
        let viewController = CategoryAddViewController(viewModel: viewModel)
        
        navigationController.present(viewController, animated: true)
    }

    func dismissReloadList() {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: true)
        }

        if let viewController = navigationController.getViewController(type: CategoryListViewController.self) {
            let viewModel = viewController.viewModel
            viewModel.fetchList()
        }
    }
}
