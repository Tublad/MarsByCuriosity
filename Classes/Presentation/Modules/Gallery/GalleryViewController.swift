//
//  GalleryViewController.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import UIKit
import Texstyle
import Framezilla
import CollectionViewTools

protocol GalleryViewInput: AnyObject {
    typealias Dependencies = HasPhotoService
    func updateCollectionView(with photos: [Photo], dependencies: Dependencies, animated: Bool)
    func updateTitleView(title: String, subtitle: String)
}

protocol GalleryViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func closeEventTriggered()
    func showPreviewEventTriggered(with index: Int)
}

final class GalleryViewController: TitleViewController {

    private let output: GalleryViewOutput
    private lazy var galleryFactory: GalleryFactory = .init(output: output)

    // MARK: - Subviews
    private lazy var collectionViewManager: CollectionViewManager = .init(collectionView: collectionView)

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset.top = 16
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    init(output: GalleryViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .main1A
        view.addSubview(collectionView)

        closeEventHandler = { [weak self] in
            self?.output.closeEventTriggered()
        }
        output.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.shadowImage = .init()
        navigationController?.navigationBar.setBackgroundImage(.init(), for: .default)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Layout

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.configureFrame { maker in
            maker.left(inset: 16).right(inset: 16).bottom().top(to: view.nui_safeArea.top)
        }
    }
}

// MARK: - GalleryViewInput

extension GalleryViewController: GalleryViewInput {
    func updateCollectionView(with photos: [Photo],
                              dependencies: Dependencies,
                              animated: Bool) {
        let sectionItems = galleryFactory.makeSectionItems(photos: photos, dependencies: dependencies)
        collectionViewManager.update(with: sectionItems, animated: animated)
    }

    func updateTitleView(title: String, subtitle: String) {
        updateTitleView(title: title, subtitle: subtitle, type: .dark)
    }
}

