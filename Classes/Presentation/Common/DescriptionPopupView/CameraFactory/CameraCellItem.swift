//
//  CameraCellItem.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 29/9/22.
//

import CollectionViewTools
import UIKit

final class CameraCellItem: CollectionViewDiffCellItem {

    typealias Cell = CameraCollectionViewCell

    var reuseType: ReuseType {
        .class(Cell.self)
    }

    var diffIdentifier: String {
        cameraType.description()
    }

    private let cameraType: CameraType
    private let isHiddenLineView: Bool

    init(cameraType: CameraType, isHiddenLineView: Bool) {
        self.cameraType = cameraType
        self.isHiddenLineView = isHiddenLineView
    }

    func isEqual(to item: DiffItem) -> Bool {
        guard let item = item as? CameraCellItem else {
            return false
        }
        return item.cameraType == cameraType
    }

    func configure(_ cell: UICollectionViewCell) {
        guard let cell = cell as? Cell else {
            return
        }

        cell.titleLabel.attributedText = cameraType.description().text(with: .subTitle1A).attributed
        cell.lineView.isHidden = isHiddenLineView
    }

    func size(in collectionView: UICollectionView, sectionItem: CollectionViewSectionItem) -> CGSize {
        .init(width: collectionView.bounds.width, height: 60)
    }
}

