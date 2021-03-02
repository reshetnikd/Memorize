//
//  Theme.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 02.03.2021.
//

import SwiftUI

struct Theme: Hashable {
    let name: String
    let emoji: [String]
    let numberOfCards: Int?
    let color: Color
}
