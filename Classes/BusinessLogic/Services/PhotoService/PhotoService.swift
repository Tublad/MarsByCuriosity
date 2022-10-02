//
//  PhotoService.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 29/9/22.
//

import UIKit.UIImage

protocol HasPhotoService {
    var photoService: PhotoService { get }
}

protocol PhotoService: AnyObject {
    func retrieveImageInCache(_ key: String) -> UIImage?
    func loadImage(with path: String, id: Int, success: @escaping (UIImage?, Int) -> Void, failure: @escaping () -> Void)
    func fetchPhotos(date: Date,
                     cameraType: CameraType,
                     success: @escaping ([Photo]) -> Void,
                     failure: @escaping () -> Void)
}

