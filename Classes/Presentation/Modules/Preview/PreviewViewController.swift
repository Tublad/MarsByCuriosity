//
//  PreviewViewController.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import UIKit
import Texstyle
import Framezilla
import CollectionViewTools

protocol PreviewViewInput: AnyObject {
    typealias Dependencies = HasPhotoService
    func updateTitleView(subtitle: Int)
    func updateCollectionView(index: Int, photos: [Photo], dependencies: Dependencies)
}

protocol PreviewViewOutput: AnyObject {
    func viewDidAppear()
    func closeEventTriggered()
    func shareEventTriggered()
    func changeIndexEventTriggered(_ index: Int)
}

final class PreviewViewController: TitleViewController {

    private let output: PreviewViewOutput

    private lazy var previewFactory: PreviewFactory = .init()

    // MARK: - Subviews
    private lazy var shareButton: UIBarButtonItem = .init(image: Asset.share.image.withRenderingMode(.alwaysTemplate),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(shareButtonPressed))

    private lazy var collectionViewManager: CollectionViewManager = {
        let collectionViewManager = CollectionViewManager(collectionView: collectionView)
        collectionViewManager.scrollDelegate = self
        return collectionViewManager
    }()
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    init(output: PreviewViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .main2A
        view.addSubview(collectionView)

        shareButton.tintColor = .main3A
        navigationItem.rightBarButtonItem = shareButton

        closeEventHandler = { [weak self] in
            self?.output.closeEventTriggered()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: - Layout

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.configureFrame { maker in
            maker.left(inset: 16).right(inset: 16)
                .bottom(to: view.nui_safeArea.bottom).top(to: view.nui_safeArea.top)
        }
    }

    // MARK: - Action

    @objc private func shareButtonPressed() {
        output.shareEventTriggered()
    }
}

// MARK: - PreviewViewInput

extension PreviewViewController: PreviewViewInput {
    func updateTitleView(subtitle: Int) {
        updateTitleView(title: L10n.Preview.title, subtitle: String(subtitle), type: .light)
    }

    func updateCollectionView(index: Int, photos: [Photo], dependencies: Dependencies) {
        let sectionItems = previewFactory.makeSectionItems(photos: photos, dependencies: dependencies)
        collectionViewManager.update(with: sectionItems, animated: false)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: .init(row: index, section: 0),
                                             at: .right,
                                             animated: false)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension PreviewViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        output.changeIndexEventTriggered(index)
    }
}
