//
//  PhotoServiceImp.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 29/9/22.
//

import Foundation
import Alamofire
import Kingfisher
import UIKit.UIImage

final class PhotoServiceImp: PhotoService {

    private struct Response: Decodable {
        let photos: [Photo]
    }

    init() { }

    func fetchPhotos(date: Date,
                     cameraType: CameraType,
                     success: @escaping ([Photo]) -> Void,
                     failure: @escaping () -> Void) {
        let path = L10n.link(date.convertDateInString(L10n.fetchDateFormate), cameraType, AppConfiguration.token)
        let request = AF.request(path)
        request.response { response in
            switch response.result {
            case .success(let data):
                guard let data = data,
                      let response = try? JSONDecoder().decode(Response.self, from: data) else {
                    return failure()
                }
                success(response.photos)
            case .failure:
                failure()
            }
        }
    }

    func loadImage(with path: String, id: Int, success: @escaping (UIImage?, Int) -> Void, failure: @escaping () -> Void) {
        guard let url = URL(string: path) else {
            return
        }

        let resource = ImageResource(downloadURL: url, cacheKey: path)
        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result {
            case .success(let retrieveImage):
                success(retrieveImage.image, id)
            case .failure:
                failure()
            }
        }
    }

    func retrieveImageInCache(_ key: String) -> UIImage? {
        KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: key)
    }
}
