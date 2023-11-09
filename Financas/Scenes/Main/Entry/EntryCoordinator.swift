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
    
    weak var delegate: EntryCoordinatorDelegate?

    init(navigationController: UINavigationController, delegate: EntryCoordinatorDelegate?) {
        self.navigationController = navigationController
        self.delegate = delegate
    }

    func start() {
        let viewModel = EntryListViewModel(coordinator: self)
        let viewController = EntryListViewController(viewModel: viewModel)
        viewController.tabBarItem = .init(title: "Lançamentos", 
                                          image: UIImage(systemName: "dollarsign.square"),
                                          selectedImage: UIImage(systemName: "dollarsign.square.fill"))
        viewController.tabBarItem.tag = 0

        navigationController.setViewControllers([viewController], animated: true)
    }
}

extension EntryCoordinator: EntryCoordinatorProtocol {
    func continueToAddEntry() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue

        navigationController.present(viewController, animated: true)
    }
}
