//
//  CameraType.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 29/9/22.
//

enum CameraType: String, CaseIterable {
    case fhaz
    case rhaz
    case mast
    case chemcam
    case mahli
    case mardi
    case navcam
    case pancam
    case minites

    func description() -> String {
        switch self {
        case .fhaz:
            return L10n.Camera.fhaz
        case .rhaz:
            return L10n.Camera.rhaz
        case .mast:
            return L10n.Camera.mast
        case .chemcam:
            return L10n.Camera.chemcam
        case .mahli:
            return L10n.Camera.mahli
        case .mardi:
            return L10n.Camera.mardi
        case .navcam:
            return L10n.Camera.navcam
        case .pancam:
            return L10n.Camera.pancam
        case .minites:
            return L10n.Camera.minites
        }
    }

    static func listCameraType() -> [CameraType] {
        [.fhaz, rhaz, .mast, .chemcam, .mahli, .mardi, .navcam, .pancam, .minites]
    }
}
