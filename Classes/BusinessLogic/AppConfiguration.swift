//
//  AppConfiguration.swift
//  MarsByCuriosity
//
//  Created by Evgeny Schwarzkopf on 28/9/22.
//

import Foundation

final class AppConfiguration {
    static let locale: Locale = .init(identifier: L10n.Picker.locale)
    // token B8o2mwgVd2zmq2UGV7wMO6hJYFjs3nwz2bZkj09I
    static var token: String = "0oID7Dh6TT1IPGGhhI2KHMgg8Q0VSL4Sb1mB7GTMwIKr3oMCf1vKOUP09whz/teL".aesDecrypt()
}
