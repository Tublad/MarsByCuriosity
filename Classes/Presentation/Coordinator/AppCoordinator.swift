//
//  AppCoordinator.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import UIKit

final class AppCoordinator: Coordinator<NavigationController> {
    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        let navigationController = NavigationController()
        super.init(rootViewController: navigationController)
    }

    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        startMainCoordinator()
    }

    private func startMainCoordinator() {
        let coordinator = MainCoordinator(rootViewController: rootViewController)
        coordinator.start()
    }
}
