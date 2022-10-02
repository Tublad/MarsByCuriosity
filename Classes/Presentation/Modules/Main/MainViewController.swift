//
//  MainViewController.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import UIKit
import Texstyle
import Framezilla
import DatePickerDialog

protocol MainViewInput: AnyObject {
    func updateDateView(with dateString: String)
    func updateRoverCameraView(with cameraType: CameraType, isNeedUpdateView: Bool)
    func updateCameraTypes(with currentCameraType: CameraType)
    func updateTitleView(title: String)
    func displayPlaceholder(with state: PlaceholderView.PlaceholderState?)
}

protocol MainViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func calendarEventTriggered()
    func changeCameraTypeEventTriggered()
    func selectCameraTypeEventTriggered(_ cameraType: CameraType)
    func exploreEventTriggered()
    func changeDirectionEventTriggered(_ direction: DescriptionPopupView.Direction)
}

final class MainViewController: TitleViewController {

    private enum Constants {
        static let inset: CGFloat = 24
        static let height: CGFloat = 60
    }

    private let output: MainViewOutput

    // MARK: - Subviews

    private lazy var containerView: UIView = .init()

    private lazy var roverCameraLabel: UILabel = {
        let label = UILabel()
        label.attributedText = L10n.Main.roverCameraTitle.text(with: .subTitle2A).attributed
        return label
    }()

    private lazy var roverCameraDescriptionView: DescriptionPopupView = {
        let view = DescriptionPopupView(type: .dropDown)
        view.actionEventHandler = { [weak self] in
            self?.output.changeCameraTypeEventTriggered()
        }
        view.selectCameraEventHandler = { [weak self] cameraType in
            self?.output.selectCameraTypeEventTriggered(cameraType)
        }
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = L10n.Main.dateTitle.text(with: .subTitle2A).attributed
        return label
    }()

    private lazy var dateDescriptionView: DescriptionView = {
        let view = DescriptionView(type: .calendar)
        view.actionEventHandler = { [weak self] in
            self?.output.calendarEventTriggered()
        }
        return view
    }()

    private lazy var exploreButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(L10n.Main.buttonExploreTitle.text(with: .button1A).attributed,
                                  for: .normal)
        button.backgroundColor = .accent1A
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(exploreButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var placeholderView: PlaceholderView = {
        let placeholderView = PlaceholderView()
        placeholderView.retryEventHandler = { [weak self] in
            self?.output.exploreEventTriggered()
        }
        placeholderView.closeEventHandler = { [weak self] in
            self?.displayPlaceholder(with: nil)
        }
        placeholderView.isHidden = true
        return placeholderView
    }()

    init(output: MainViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        output.viewDidLoad()
    }

    override func loadView() {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.image = Asset.background.image
        imageView.isUserInteractionEnabled = true
        view = imageView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: - Layout

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let container = [roverCameraLabel, roverCameraDescriptionView, dateLabel, dateDescriptionView, exploreButton]
        container.configure(container: containerView,
                            relation: .horizontal(left: Constants.inset,
                                                  right: Constants.inset)) {
            roverCameraLabel.configureFrame { maker in
                maker.top(inset: Constants.inset).left().right().heightToFit()
            }
            roverCameraDescriptionView.configureFrame { maker in
                maker.left().right().top(to: roverCameraLabel.nui_bottom, inset: 7).height(Constants.height)
            }
            dateLabel.configureFrame { maker in
                maker.left().right().top(to: roverCameraDescriptionView.nui_bottom, inset: 16).heightToFit()
            }
            dateDescriptionView.configureFrame { maker in
                maker.left().right().top(to: dateLabel.nui_bottom, inset: 7).height(Constants.height)
            }
            exploreButton.configureFrame { maker in
                maker.left().right().top(to: dateDescriptionView.nui_bottom, inset: 40).height(Constants.height)
            }
        }

        containerView.configureFrame { maker in
            maker.centerX().centerY(offset: 20)
        }

        placeholderView.configureFrame { maker in
            maker.center(to: containerView).height(containerView.frame.height + 1).width(containerView.frame.width + 1)
        }
    }

    // MARK: - Private

    private func addView() {
        containerView.addSubview(roverCameraLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(dateDescriptionView)
        containerView.addSubview(exploreButton)
        containerView.addSubview(roverCameraDescriptionView)

        view.addSubview(containerView)
        view.addSubview(placeholderView)
    }

    private func updateRoverCameraViewHeight() {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.roverCameraDescriptionView.configureFrame { maker in
                switch self.roverCameraDescriptionView.direction {
                case .up:
                    maker.height(60)
                case .down:
                    maker.height(240)
                }
            }
            self.roverCameraDescriptionView.updateState()
        }
    }

    private func showPlaceholderView(isHidden: Bool) {
        placeholderView.isHidden = isHidden
    }

    // MARK: - Action

    @objc private func exploreButtonPressed() {
        if roverCameraDescriptionView.direction == .up {
            updateRoverCameraViewHeight()
        }
        output.exploreEventTriggered()
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {

    func updateTitleView(title: String) {
        updateTitleView(title: title, type: .dark)
    }

    func updateDateView(with dateString: String) {
        dateDescriptionView.updateTitle(dateString)
    }

    func updateRoverCameraView(with cameraType: CameraType, isNeedUpdateView: Bool) {
        roverCameraDescriptionView.updateTitle(cameraType.description())
        if isNeedUpdateView {
            updateRoverCameraViewHeight()
        }
    }

    func updateCameraTypes(with currentCameraType: CameraType) {
        roverCameraDescriptionView.updateCollectionView(currentCameraType)
        updateRoverCameraViewHeight()
        output.changeDirectionEventTriggered(roverCameraDescriptionView.direction)
    }

    func displayPlaceholder(with state: PlaceholderView.PlaceholderState?) {
        switch state {
        case .loading:
            placeholderView.setupPlaceholderView(with: .loading)
        case .noConnection:
            placeholderView.setupPlaceholderView(with: .noConnection)
        case .notFound:
            placeholderView.setupPlaceholderView(with: .notFound)
        case .somethingWrong:
            placeholderView.setupPlaceholderView(with: .somethingWrong)
        default:
            break
        }
        showPlaceholderView(isHidden: state == nil)
    }
}

