//
//  TitleViewController.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import UIKit
import Texstyle

class TitleViewController: UIViewController {

    enum TitleColor {
        case dark
        case light
    }

    var closeEventHandler: (() -> Void)?

    // MARK: - Subviews

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .init(origin: .zero, size: .init(width: 150, height: .zero)))
        label.numberOfLines = 2
        return label
    }()

    private lazy var backButton: UIBarButtonItem = .init(image: Asset.back.image.withRenderingMode(.alwaysTemplate),
                                                         style: .plain,
                                                         target: self,
                                                         action: #selector(backButtonPressed))

    func updateTitleView(title: String, subtitle: String? = nil, type: TitleColor) {
        switch type {
        case .dark:
            if let subtitle = subtitle {
                makeTitleView(title: title,
                              subtitle: subtitle,
                              titleTextStyle: .title1A,
                              subtitleTextStyle: .subTitle2A)
            }
            else {
                titleLabel.attributedText = title.text(with: .title1A).attributed
            }
        case .light:
            guard let subtitle = subtitle else {
                return
            }
            makeTitleView(title: title,
                          subtitle: subtitle,
                          titleTextStyle: .subTitle2B,
                          subtitleTextStyle: .title1B)
        }

        navigationItem.titleView = titleLabel
        if subtitle != nil {
            backButton.tintColor = type == .dark ? .main2A : .main3A
            navigationItem.leftBarButtonItem = backButton
        }
    }

    // MARK: - Private

    private func makeTitleView(title: String,
                               subtitle: String,
                               titleTextStyle: TextStyle,
                               subtitleTextStyle: TextStyle) {
        let text = Text(value: title + L10n.newLine + subtitle, style: titleTextStyle.centerAligned())
        text.add(subtitleTextStyle.centerAligned(), for: subtitle)
        titleLabel.attributedText = text.attributed
    }

    // MARK: - Action

    @objc private func backButtonPressed() {
        closeEventHandler?()
    }
}
