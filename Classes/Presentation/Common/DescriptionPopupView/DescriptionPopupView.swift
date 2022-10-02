//
//  DescriptionPopupView.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 29/9/22.
//

import Framezilla
import CollectionViewTools

final class DescriptionPopupView: DescriptionView {

    enum Direction {
        case up
        case down
    }

    var direction: Direction = .down
    var selectCameraEventHandler: ((CameraType) -> Void)?

    private let cameraTypes: [CameraType] = CameraType.listCameraType()
    private lazy var cameraFactory: CameraFactory = .init()
    private var isShowCollectionView: Bool = false

    // MARK: - Subviews

    private lazy var collectionViewManager: CollectionViewManager = .init(collectionView: collectionView)
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .main1A
        collectionView.bounces = false
        return collectionView
    }()

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.configureFrame { maker in
            maker.left().right().bottom().top(to: titleLabel.nui_bottom, inset: 18)
        }
    }

    override func setup() {
        super.setup()
        addSubview(collectionView)
        let sectionItems = cameraFactory.makeSectionItem(cameraTypes: cameraTypes)
        collectionViewManager.update(with: sectionItems, animated: false)
        cameraFactory.itemDidSelectEventHandler = { [weak self] cameraType in
            self?.selectCameraEventHandler?(cameraType)
        }
    }

    func updateCollectionView(_ cameraType: CameraType) {
        guard let index = cameraTypes.firstIndex(of: cameraType) else {
            return
        }
        collectionView.scrollToItem(at: .init(row: index,
                                              section: 0),
                                    at: .top,
                                    animated: false)
    }

    func updateState() {
        switch direction {
        case .up:
            actionButton.transform = .init(rotationAngle: .pi * 2)
            direction = .down
        case .down:
            actionButton.transform = .init(rotationAngle: .pi)
            direction = .up
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
}
