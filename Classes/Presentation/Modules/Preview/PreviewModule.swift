//
//  PreviewModule.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import UIKit.UIImage

protocol PreviewModuleInput: AnyObject {

}

protocol PreviewModuleOutput: AnyObject {
    func previewModuleClosed(_ moduleInput: PreviewModuleInput)
    func previewModule(_ moduleInput: PreviewModuleInput, shareEventTriggered image: UIImage)
}

final class PreviewModule {

    var input: PreviewModuleInput {
        return presenter
    }

    let viewController: PreviewViewController
    private let presenter: PreviewPresenter

    init(state: PreviewState, output: PreviewModuleOutput?) {
        let presenter = PreviewPresenter(state: state,
                                         dependencies: Services,
                                         output: output)
        let viewController = PreviewViewController(output: presenter)
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}

