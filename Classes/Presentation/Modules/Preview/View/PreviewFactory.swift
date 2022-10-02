//
//  PreviewFactory.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import CollectionViewTools

final class PreviewFactory {

    typealias Dependencies = HasPhotoService

    func makeSectionItems(photos: [Photo], dependencies: Dependencies) -> [GeneralCollectionViewDiffSectionItem] {
        let cellItems = photos.map { photo in
            PreviewCellItem(photo: photo, contentMode: .scaleAspectFit, dependencies: dependencies)
        }

        let sectionItem = GeneralCollectionViewDiffSectionItem()
        sectionItem.cellItems = cellItems
        return [sectionItem]
    }
}
