//
//  PreviewState.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import Foundation

final class PreviewState {

    let photos: [Photo]
    var currentIndex: Int

    init(currentIndex: Int, photos: [Photo]) {
        self.currentIndex = currentIndex
        self.photos = photos
    }
}
