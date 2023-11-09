//  
//  RootViewController.swift
//  Financas
//
//  Created by Adonay on 08/11/23.
//

import UIKit

class RootViewController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        presentedViewController ?? visibleViewController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        (presentedViewController ?? visibleViewController)?.preferredStatusBarStyle ?? .darkContent
    }
}
