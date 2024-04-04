//
//  EntryCoordinator.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import UIKit

class EntryCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var service: FinancasServiceProtocol

    weak var delegate: EntryCoordinatorDelegate?

    init(navigationController: UINavigationController, 
         service: FinancasServiceProtocol,
         delegate: EntryCoordinatorDelegate?) {
        self.navigationController = navigationController
        self.service = service
        self.delegate = delegate
    }

    func start() {
        let viewModel = EntryListViewModel(service: service, coordinator: self)
        let viewController = EntryListViewController(viewModel: viewModel)
        viewController.tabBarItem = .init(title: "Lançamentos", 
                                          image: UIImage(systemName: "dollarsign.square"),
                                          selectedImage: UIImage(systemName: "dollarsign.square.fill"))
        viewController.tabBarItem.tag = 0
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([viewController], animated: true)
    }
}

extension EntryCoordinator: EntryCoordinatorProtocol {
    func continueToAddEntry() {
        let viewModel = EntryAddViewModel(service: service, coordinator: self)
        let viewController = EntryAddViewController(viewModel: viewModel)
        navigationController.present(viewController, animated: true)
    }

    func dismissReloadList() {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: true)
        }

        if let viewController = navigationController.getViewController(type: EntryListViewController.self) {
            let viewModel = viewController.viewModel
            viewModel.fetchList()
        }
    }
}
