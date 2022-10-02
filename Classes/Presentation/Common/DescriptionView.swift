//
//  DescriptionView.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import UIKit
import Framezilla

class DescriptionView: UIView {

    enum IconType {
        case dropDown
        case calendar
    }

    var actionEventHandler: (() -> Void)?

    private let type: IconType

    // MARK: - Subviews

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .main3A
        view.layer.opacity = 0.5
        view.isUserInteractionEnabled = true
        return view
    }()

    private(set) lazy var titleLabel: UILabel = .init()

    private(set) lazy var actionButton: UIButton = {
        let button = UIButton()
        switch type {
        case .dropDown:
            button.setImage(Asset.dropdown.image, for: .normal)
        case .calendar:
            button.setImage(Asset.calendar.image, for: .normal)
        }
        button.isEnabled = false
        return button
    }()

    init(type: IconType) {
        self.type = type
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        self.type = .dropDown
        super.init(coder: coder)
        setup()
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = bounds

        actionButton.configureFrame { maker in
            maker.sizeToFit().right(inset: 12).top(inset: 18)
        }

        titleLabel.configureFrame { maker in
            maker.sizeToFit().left(inset: 16).centerY(to: actionButton.nui_centerY)
        }
    }

    func updateTitle(_ text: String) {
        titleLabel.attributedText = text.text(with: .subTitle1A).attributed
        setNeedsLayout()
        layoutIfNeeded()
    }

    func setup() {
        addSubview(backgroundView)
        addSubview(actionButton)
        addSubview(titleLabel)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selfPressed))
        backgroundView.addGestureRecognizer(tapGesture)

        layer.cornerRadius = 10
        backgroundColor = .clear
        clipsToBounds = true
    }

    // MARK: - Action

    @objc private func selfPressed() {
        actionEventHandler?()
    }
}
