//
//  TextStyles.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import Foundation
import Texstyle

extension TextStyle {

    static var title1A: TextStyle {
        let style = TextStyle()
        style.font = .dosis(ofSize: 18, weight: .semiBold)
        style.color = .main2A
        style.alignment = .center
        style.lineHeight = 22
        return style
    }

    static var title1B: TextStyle {
        let style = TextStyle.title1A
        style.color = .main3A
        return style
    }

    static var subTitle1A: TextStyle {
        let style = TextStyle()
        style.font = .dosis(ofSize: 18, weight: .regular)
        style.alignment = .left
        style.lineHeight = 22.75
        style.kerning = 0.02
        style.color = .main2A
        return style
    }

    static var subTitle2A: TextStyle {
        let style = TextStyle()
        style.font = .dosis(ofSize: 14, weight: .regular)
        style.alignment = .left
        style.lineHeight = 17.7
        style.kerning = 0.02
        style.color = .main2A
        return style
    }

    static var subTitle2B: TextStyle {
        let style = TextStyle.subTitle2A
        style.color = .main3A
        return style
    }

    static var button1A: TextStyle = {
        let style = title1A
        style.color = .main3A
        style.lineHeight = 22.75
        style.kerning = 0.02
        return style
    }()

}

