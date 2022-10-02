//
//  GalleryState.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import Foundation

final class GalleryState {

    var date: Date
    var cameraType: CameraType
    var photos: [Photo]

    init(date: Date, cameraType: CameraType, photos: [Photo]) {
        self.date = date
        self.cameraType = cameraType
        self.photos = photos
    }
}
