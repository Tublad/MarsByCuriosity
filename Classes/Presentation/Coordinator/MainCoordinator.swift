//
//  MainCoordinator.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import UIKit
import DatePickerDialog

final class MainCoordinator: Coordinator<UINavigationController> {
    override init(rootViewController: UINavigationController) {
        super.init(rootViewController: rootViewController)
    }

    func start() {
        let module = MainModule(output: self)
        rootViewController.pushViewController(module.viewController, animated: false)
    }
}

extension MainCoordinator: MainModuleOutput {
    func mainModule(_ moduleInput: MainModuleInput, showGalleryEventTriggered photos: [Photo]) {
        let coordinator = GalleryCoordinator(rootViewController: rootViewController)
        coordinator.start(with: .init(date: moduleInput.state.date,
                                      cameraType: moduleInput.state.cameraType,
                                      photos: photos))
    }

    func mainModule(_ moduleInput: MainModuleInput,
                    calendarEventTriggered date: Date,
                    completion: @escaping (Date) -> Void) {
        let pickerDialog = DatePickerDialog(textColor: .main2A,
                                            buttonColor: .main2A,
                                            font: .dosis(ofSize: 18, weight: .regular),
                                            locale: AppConfiguration.locale,
                                            showCancelButton: true)
        pickerDialog.show(L10n.Picker.title,
                          doneButtonTitle: L10n.Picker.applyTitle,
                          cancelButtonTitle: L10n.Picker.cancelTitle,
                          defaultDate: date,
                          maximumDate: Date(),
                          datePickerMode: .date) { date in
            guard let date = date else {
                return
            }
            completion(date)
        }
    }
}
