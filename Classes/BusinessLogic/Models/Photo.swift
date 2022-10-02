//
//  Photo.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 29/9/22.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let sol: Int
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case imagePath = "img_src"
    }
}
