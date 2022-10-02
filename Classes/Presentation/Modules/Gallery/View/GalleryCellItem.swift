//
//  GalleryCellItem.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import CollectionViewTools
import UIKit
import Kingfisher

class GalleryCellItem: CollectionViewDiffCellItem {

    typealias Cell = GalleryCollectionViewCell
    typealias Dependencies = HasPhotoService

    var reuseType: ReuseType {
        .class(Cell.self)
    }

    var diffIdentifier: String {
        "id:\(photo.id) sol:\(photo.sol)"
    }

    private let photo: Photo
    private let contentMode: UIImageView.ContentMode
    private let dependencies: Dependencies

    init(photo: Photo, contentMode: UIImageView.ContentMode, dependencies: Dependencies) {
        self.photo = photo
        self.contentMode = contentMode
        self.dependencies = dependencies
    }

    func isEqual(to item: DiffItem) -> Bool {
        guard let item = item as? GalleryCellItem else {
            return false
        }
        return item.photo.id == photo.id &&
               item.photo.sol == photo.sol
    }

    func configure(_ cell: UICollectionViewCell) {
        guard let cell = cell as? Cell,
              let url = URL(string: photo.imagePath) else {
            return
        }
        cell.imageView.contentMode = contentMode
        updateTintColor(cell, contentMode: contentMode)

        if let image = dependencies.photoService.retrieveImageInCache(photo.imagePath) {
            cell.hideActivityIndicatorView()
            cell.imageView.image = image
        }
        else {
            loadImage(cell, with: url)
        }

        cell.retryEventHandler = { [weak self] in
            self?.loadImage(cell, with: url)
        }
    }

    func size(in collectionView: UICollectionView, sectionItem: CollectionViewSectionItem) -> CGSize {
        let cellWidth = (collectionView.bounds.width - (sectionItem.minimumInteritemSpacing * (3 - 1))) / 3
        return .init(width: cellWidth, height: cellWidth)
    }

    private func loadImage(_ cell: Cell, with url: URL) {
        cell.showActivityIndicatorView()

        dependencies.photoService.loadImage(with: photo.imagePath,
                                            id: photo.id) { [weak self] image, id in
            guard let self = self,
                  self.photo.id == id else {
                return
            }
            cell.imageView.image = image
            cell.hideActivityIndicatorView()
        } failure: {
            cell.showRetryButton()
        }
    }

    private func updateTintColor(_ cell: Cell, contentMode: UIImageView.ContentMode) {
        switch contentMode {
        case .scaleAspectFit:
            cell.updateTintColor(.main3A)
        case .scaleAspectFill:
            cell.updateTintColor(.main2A)
        default:
            break
        }
    }
}
