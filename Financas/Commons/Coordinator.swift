//  
//  Coordinator.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import UIKit

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func getCoordinator<T>(type: T.Type) -> T?
}

extension Coordinator {
    func getCoordinator<T>(type: T.Type) -> T? {
        return self.childCoordinators.first(where: { $0 is T }) as? T
    }
}
