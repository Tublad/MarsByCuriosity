//
//  ServiceFactory.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import Foundation

typealias ServicesAlias = HasPhotoService &
                          HasReachabilityService

var Services: ServicesAlias {
    return MainServicesFactory()
}

final class MainServicesFactory: ServicesAlias {
    lazy var photoService: PhotoService = PhotoServiceImp()
    lazy var reachabilityService: ReachabilityService = ReachabilityServiceImp()
}
