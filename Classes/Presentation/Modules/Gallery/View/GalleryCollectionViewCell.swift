//
//  GalleryCollectionViewCell.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import UIKit
import Framezilla

class GalleryCollectionViewCell: UICollectionViewCell {

    var retryEventHandler: (() -> Void)?

    // MARK: - Subviews

    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.isHidden = true
        return view
    }()

    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: L10n.SystemImageName.gobackward), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
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

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds

        activityIndicatorView.sizeToFit()
        activityIndicatorView.center = contentView.center

        retryButton.sizeToFit()
        retryButton.center = contentView.center
    }

    func showActivityIndicatorView() {
        activityIndicatorView.isHidden = false
        retryButton.isHidden = true
        imageView.isHidden = true
        activityIndicatorView.startAnimating()
    }

    func hideActivityIndicatorView() {
        activityIndicatorView.isHidden = true
        retryButton.isHidden = true
        imageView.isHidden = false
        activityIndicatorView.stopAnimating()
    }

    func showRetryButton() {
        hideActivityIndicatorView()
        retryButton.isHidden = false
    }

    func updateTintColor(_ tintColor: UIColor) {
        activityIndicatorView.tintColor = tintColor
        retryButton.tintColor = tintColor
    }

    // MARK: - Private

    private func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicatorView)
        contentView.addSubview(retryButton)

        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
    }

    // MARK: - Action

    @objc private func retryButtonPressed() {
        retryEventHandler?()
    }
}
