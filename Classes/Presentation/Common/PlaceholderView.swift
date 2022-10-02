//
//  PlaceholderView.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import UIKit
import Foundation

class PlaceholderView: UIView {

    enum PlaceholderState {
        case loading
        case noConnection
        case notFound
        case somethingWrong
    }

    var retryEventHandler: (() -> Void)?
    var closeEventHandler: (() -> Void)?
    private let screenEdgeIndent: CGFloat = 25.0

    // MARK: - Subviews

    private lazy var containerView: UIView = .init()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setText(L10n.Main.buttonRetryTitle.text(with: .button1A))
        button.backgroundColor = .accent1A
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    private lazy var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .medium)
        spinnerView.hidesWhenStopped = true
        spinnerView.isHidden = true
        spinnerView.tintColor = .main2A
        return spinnerView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.backgroundColor = .clear
        button.setImage(Asset.close.image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setupPlaceholderView(with state: PlaceholderState, with action: UITapGestureRecognizer = UITapGestureRecognizer()) {
        switch state {
        case .loading:
            spinnerView.startAnimating()
            titleLabel.isHidden = true
            subtitleLabel.isHidden = true
            spinnerView.isHidden = false
            retryButton.isHidden = true
        case .noConnection:
            titleLabel.attributedText = L10n.Error.NoInternetConnection.title.text(with: .title1A.centerAligned()).attributed
            subtitleLabel.attributedText = L10n.Error.NoInternetConnection.description.text(with: .subTitle1A.centerAligned()).attributed
            showPlaceholderWithoutButton()
        case .notFound:
            titleLabel.attributedText = L10n.Error.NotFound.title.text(with: .title1A.centerAligned()).attributed
            subtitleLabel.attributedText = L10n.Error.NotFound.description.text(with: .subTitle1A.centerAligned()).attributed
            showPlaceholderWithoutButton()
        case .somethingWrong:
            titleLabel.attributedText = L10n.Error.SomethingWentWrong.title.text(with: .title1A.centerAligned()).attributed
            subtitleLabel.attributedText = L10n.Error.SomethingWentWrong.description.text(with: .subTitle1A.centerAligned()).attributed
            spinnerView.stopAnimating()
            titleLabel.isHidden = false
            spinnerView.isHidden = true
            retryButton.isHidden = false
            subtitleLabel.isHidden = false
        }
        backgroundColor = state == .loading ? .clear : .main3A
        closeButton.isHidden = state == .loading
        setNeedsLayout()
    }

    // MARK: - Layout

    override func layoutSubviews() {
        containerView.frame = bounds
        [titleLabel, subtitleLabel, spinnerView, retryButton]
            .configure(container: containerView, relation: .horizontal(left: screenEdgeIndent, right: screenEdgeIndent)) {
                titleLabel.configureFrame { maker in
                    maker.top().left().right().heightToFit()
                }

                subtitleLabel.configureFrame { maker in
                    maker.top(to: titleLabel.nui_bottom, inset: 5)
                        .left().right().heightToFit()
                }

                spinnerView.configureFrame { maker in
                    maker.center().sizeToFit()
                }

                retryButton.configureFrame { maker in
                    maker.top(to: subtitleLabel.nui_bottom, inset: 5).centerX()
                        .size(width: 160, height: 40)
                }
            }

        containerView.configureFrame { maker in
            maker.center()
        }

        closeButton.configureFrame { maker in
            maker.sizeToFit().right(inset: 16).top(inset: 16)
        }
    }

    // MARK: - Private

    private func setup() {
        layer.cornerRadius = 10
        clipsToBounds = true
        containerView.backgroundColor = .clear

        addSubview(containerView)
        addSubview(closeButton)
    }

    private func showPlaceholderWithoutButton() {
        spinnerView.stopAnimating()
        titleLabel.isHidden = false
        spinnerView.isHidden = true
        retryButton.isHidden = true
        subtitleLabel.isHidden = false
    }

    // MARK: - Action

    @objc private func retryButtonPressed() {
        retryEventHandler?()
    }

    @objc private func closeButtonPressed() {
        closeEventHandler?()
    }
}

