//
//  PreviewCoordinator.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import UIKit

final class PreviewCoordinator: Coordinator<NavigationController> {

    override init(rootViewController: NavigationController) {
        super.init(rootViewController: rootViewController)
    }

    func start(with state: PreviewState) {
        let module = PreviewModule(state: state, output: self)
        rootViewController.pushViewController(module.viewController, animated: false)
    }
}

extension PreviewCoordinator: PreviewModuleOutput {
    func previewModule(_ moduleInput: PreviewModuleInput, shareEventTriggered image: UIImage) {
        let activityItems = [image]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        rootViewController.present(activityViewController, animated: true)
    }

    func previewModuleClosed(_ moduleInput: PreviewModuleInput) {
        rootViewController.popViewController(animated: true)
    }
}
