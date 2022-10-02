//
//  UIFonts.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import UIKit

extension UIFont {

    enum DosisWeight: String {
        case semiBold = "-SemiBold"
        case regular = "-Regular"
        case extraLight = "-ExtraLight"
    }

    static func dosis(ofSize size: CGFloat, weight: DosisWeight) -> UIFont {
        let name = "Dosis\(weight.rawValue)"
        if let font = UIFont(name: name, size: size) {
            return font
        }
        print("ERROR: could not find font with name = \(name)")
        return UIFont.systemFont(ofSize: size)
    }
}
