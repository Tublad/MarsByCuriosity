//
//  GalleryPresenter.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import Foundation

final class GalleryPresenter {

    typealias Dependencies = HasPhotoService

    weak var view: GalleryViewInput?

    var state: GalleryState

    private let dependencies: Dependencies
    private let output: GalleryModuleOutput?

    init(state: GalleryState,
         dependencies: Dependencies,
         output: GalleryModuleOutput?) {
        self.state = state
        self.dependencies = dependencies
        self.output = output
    }
}

// MARK: - GalleryViewOutput

extension GalleryPresenter: GalleryViewOutput {
    func viewDidLoad() {
        view?.updateCollectionView(with: state.photos, dependencies: dependencies, animated: true)
    }

    func viewDidAppear() {
        view?.updateTitleView(title: state.cameraType.description(), subtitle: state.date.convertDateInString())
    }

    func closeEventTriggered() {
        output?.galleryClosed(self)
    }

    func showPreviewEventTriggered(with index: Int) {
        guard dependencies.photoService.retrieveImageInCache(state.photos[index].imagePath) != nil else {
            return
        }
        output?.galleryModule(self, showPreviewEventTriggered: index)
    }
}

// MARK: - GalleryModuleInput

extension GalleryPresenter: GalleryModuleInput {

}

