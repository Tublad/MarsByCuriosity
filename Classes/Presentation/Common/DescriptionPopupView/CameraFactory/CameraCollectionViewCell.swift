//
//  CameraCollectionViewCell.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 29/9/22.
//

import UIKit

final class CameraCollectionViewCell: UICollectionViewCell {

    // MARK: - Subviews

    private(set) lazy var titleLabel: UILabel = .init()
    private(set) lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .main3A
        return view
    }()

    private lazy var backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .main3A
        view.layer.opacity = 0.5
        view.isUserInteractionEnabled = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColorView.frame = bounds
        titleLabel.configureFrame { maker in
            maker.left(inset: 16).right(inset: 16).sizeToFit().centerY()
        }
        lineView.configureFrame { maker in
            maker.left(inset: 16).right(inset: 16).bottom(to: nui_bottom, inset: -1).height(1)
        }
    }

    // MARK: - Private

    private func setup() {
        contentView.addSubview(backgroundColorView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lineView)
        contentView.backgroundColor = .clear
    }
}
