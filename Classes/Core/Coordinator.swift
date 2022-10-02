//
//  Coordinator.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import UIKit

open class Coordinator<V: UIViewController> {

    open var rootViewController: V

    public init(rootViewController: V) {
        self.rootViewController = rootViewController
    }
}
