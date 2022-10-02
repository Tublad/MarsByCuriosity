//
//  MainPresenter.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import Foundation
import UIKit.UIApplication

final class MainPresenter {

    typealias Dependencies = HasPhotoService &
                             HasReachabilityService

    weak var view: MainViewInput?

    var state: MainState

    private let dependencies: Dependencies
    private let output: MainModuleOutput?

    init(state: MainState,
         dependencies: Dependencies,
         output: MainModuleOutput?) {
        self.state = state
        self.dependencies = dependencies
        self.output = output
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didEnterBackgroundNotification,
                                                  object: nil)
    }

    // MARK: - Private

    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterBackgroundNotification),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
    }

    @objc private func didEnterBackgroundNotification() {
        if state.direction == .up {
            view?.updateCameraTypes(with: state.cameraType)
        }
    }
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    func viewDidLoad() {
        view?.updateRoverCameraView(with: state.cameraType, isNeedUpdateView: false)
        view?.updateDateView(with: state.date.convertDateInString())
        setupNotificationCenter()
    }

    func viewDidAppear() {
        view?.updateTitleView(title: L10n.Main.title)
    }

    func calendarEventTriggered() {
        output?.mainModule(self, calendarEventTriggered: state.date) { [weak self] date in
            guard let self = self else {
                return
            }
            self.state.date = date
            self.view?.updateDateView(with: date.convertDateInString())
        }
    }

    func selectCameraTypeEventTriggered(_ cameraType: CameraType) {
        state.cameraType = cameraType
        view?.updateRoverCameraView(with: cameraType, isNeedUpdateView: true)
    }

    func changeCameraTypeEventTriggered() {
        view?.updateCameraTypes(with: state.cameraType)
    }

    func changeDirectionEventTriggered(_ direction: DescriptionPopupView.Direction) {
        state.direction = direction
    }

    func exploreEventTriggered() {
        guard dependencies.reachabilityService.isConnectedNetwork else {
            view?.displayPlaceholder(with: .noConnection)
            return
        }
        view?.displayPlaceholder(with: .loading)
        dependencies.photoService.fetchPhotos(date: state.date, cameraType: state.cameraType) { [weak self] photos in
            guard let self = self else {
                return
            }
            if photos.isEmpty {
                self.view?.displayPlaceholder(with: .notFound)
            }
            else {
                self.view?.displayPlaceholder(with: nil)
                self.output?.mainModule(self, showGalleryEventTriggered: photos)
            }
        } failure: { [weak self] in
            self?.view?.displayPlaceholder(with: .somethingWrong)
        }
    }
}

// MARK: - MainModuleInput

extension MainPresenter: MainModuleInput {
    
}
