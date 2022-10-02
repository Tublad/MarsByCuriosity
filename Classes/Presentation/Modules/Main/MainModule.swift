//
//  MainModule.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import UIKit

protocol MainModuleInput: AnyObject {
    var state: MainState { get }
}

protocol MainModuleOutput: AnyObject {
    func mainModule(_ moduleInput: MainModuleInput, calendarEventTriggered date: Date, completion: @escaping (Date) -> Void)
    func mainModule(_ moduleInput: MainModuleInput, showGalleryEventTriggered photos: [Photo])
}

final class MainModule {

    var input: MainModuleInput {
        return presenter
    }

    let viewController: MainViewController
    private let presenter: MainPresenter

    init(state: MainState = .init(), output: MainModuleOutput?) {
        let presenter = MainPresenter(state: state,
                                      dependencies: Services,
                                      output: output)
        let viewController = MainViewController(output: presenter)
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
