//
//  GalleryModule.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import UIKit

protocol GalleryModuleInput: AnyObject {
    var state: GalleryState { get }
}

protocol GalleryModuleOutput: AnyObject {
    func galleryClosed(_ moduleInput: GalleryModuleInput)
    func galleryModule(_ moduleInput: GalleryModuleInput, showPreviewEventTriggered index: Int)
}

final class GalleryModule {

    var input: GalleryModuleInput {
        return presenter
    }

    let viewController: GalleryViewController
    private let presenter: GalleryPresenter

    init(state: GalleryState, output: GalleryModuleOutput?) {
        let presenter = GalleryPresenter(state: state,
                                         dependencies: Services,
                                         output: output)
        let viewController = GalleryViewController(output: presenter)
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
