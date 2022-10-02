//
//  PreviewCellItem.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import CollectionViewTools

final class PreviewCellItem: GalleryCellItem {
    override func size(in collectionView: UICollectionView, sectionItem: CollectionViewSectionItem) -> CGSize {
        collectionView.frame.size
    }
}
