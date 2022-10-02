//
//  GalleryCoordinator.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import UIKit

final class GalleryCoordinator: Coordinator<UINavigationController> {
    override init(rootViewController: UINavigationController) {
        super.init(rootViewController: rootViewController)
    }

    func start(with state: GalleryState) {
        let module = GalleryModule(state: state, output: self)
        rootViewController.pushViewController(module.viewController, animated: false)
    }
}

extension GalleryCoordinator: GalleryModuleOutput {

    func galleryClosed(_ moduleInput: GalleryModuleInput) {
        rootViewController.popViewController(animated: true)
    }

    func galleryModule(_ moduleInput: GalleryModuleInput, showPreviewEventTriggered index: Int) {
        let coordinator = PreviewCoordinator(rootViewController: rootViewController)
        coordinator.start(with: .init(currentIndex: index, photos: moduleInput.state.photos))
    }
}
