//
//  CameraFactory.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 29/9/22.
//

import CollectionViewTools

final class CameraFactory {

    var itemDidSelectEventHandler: ((CameraType) -> Void)?

    func makeSectionItem(cameraTypes: [CameraType]) -> [GeneralCollectionViewDiffSectionItem] {
        let cellItems = cameraTypes.map { cameraType in
            makeCellItem(cameraType: cameraType, isHiddenLineView: cameraType == .minites)
        }
        let sectionItem = GeneralCollectionViewDiffSectionItem()
        sectionItem.cellItems = cellItems
        return [sectionItem]
    }

    private func makeCellItem(cameraType: CameraType, isHiddenLineView: Bool) -> CameraCellItem {
        let cellItem = CameraCellItem(cameraType: cameraType, isHiddenLineView: isHiddenLineView)

        cellItem.itemDidSelectHandler = { [weak self] _ in
            self?.itemDidSelectEventHandler?(cameraType)
        }

        return cellItem
    }
}
