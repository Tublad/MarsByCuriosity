//
//  PreviewPresenter.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import Foundation

final class PreviewPresenter {

    typealias Dependencies = HasPhotoService

    weak var view: PreviewViewInput?

    var state: PreviewState

    private let dependencies: Dependencies
    private let output: PreviewModuleOutput?

    init(state: PreviewState,
         dependencies: Dependencies,
         output: PreviewModuleOutput?) {
        self.state = state
        self.dependencies = dependencies
        self.output = output
    }

    // MARK: - Private

    private func isContainsIndex(_ index: Int) -> Bool {
        index <= state.photos.count - 1
    }
}

// MARK: - PreviewViewOutput

extension PreviewPresenter: PreviewViewOutput {
    func viewDidAppear() {
        view?.updateCollectionView(index: state.currentIndex, photos: state.photos, dependencies: dependencies)
        view?.updateTitleView(subtitle: state.photos[state.currentIndex].id)
    }

    func closeEventTriggered() {
        output?.previewModuleClosed(self)
    }

    func changeIndexEventTriggered(_ index: Int) {
        guard isContainsIndex(index) else {
            return
        }

        state.currentIndex = index
        view?.updateTitleView(subtitle: state.photos[index].id)
    }

    func shareEventTriggered() {
        guard isContainsIndex(state.currentIndex),
              let image = dependencies.photoService.retrieveImageInCache(state.photos[state.currentIndex].imagePath) else {
            return
        }
        
        output?.previewModule(self, shareEventTriggered: image)
    }
}

// MARK: - PreviewModuleInput

extension PreviewPresenter: PreviewModuleInput {
}
