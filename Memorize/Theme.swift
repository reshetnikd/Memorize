//
//  Theme.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 02.03.2021.
//

import SwiftUI

struct Theme: Hashable, Codable {
    let name: String
    let emoji: [String]
    let numberOfCards: Int
    let color: UIColor.RGB
    
    func getColor() -> Color {
        Color(color)
    }
}
