//
//  ReachabilityService.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 1/10/22.
//

import Foundation

protocol HasReachabilityService {
    var reachabilityService: ReachabilityService { get }
}

protocol ReachabilityService: AnyObject {
    var isConnectedNetwork: Bool { get }
}
