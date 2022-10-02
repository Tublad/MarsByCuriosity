//
//  NavigationController.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 2/10/22.
//

import UIKit

class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topVC = topViewController {
            return topVC.preferredStatusBarStyle
        }
        return .default
    }
}

