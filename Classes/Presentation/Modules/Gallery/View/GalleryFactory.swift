//
//  GalleryFactory.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import CollectionViewTools

final class GalleryFactory {

    typealias Dependencies = HasPhotoService

    private weak var output: GalleryViewOutput?

    init(output: GalleryViewOutput?) {
        self.output = output
    }

    func makeSectionItems(photos: [Photo], dependencies: Dependencies) -> [GeneralCollectionViewDiffSectionItem] {
        let cellItems = photos.map { photo in
            makeCellItem(photo, dependencies: dependencies)
        }

        let sectionItem = GeneralCollectionViewDiffSectionItem()
        sectionItem.cellItems = cellItems
        sectionItem.minimumLineSpacing = 8
        sectionItem.minimumInteritemSpacing = 8
        return [sectionItem]
    }

    private func makeCellItem(_ photo: Photo, dependencies: Dependencies) -> GalleryCellItem {
        let cellItem = GalleryCellItem(photo: photo, contentMode: .scaleAspectFill, dependencies: dependencies)

        cellItem.itemDidSelectHandler = { [weak self] indexPath in
            self?.output?.showPreviewEventTriggered(with: indexPath.row)
        }

        return cellItem
    }
}
