//
//  Theme.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 02.03.2021.
//

import SwiftUI

struct Theme: Hashable, Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var emoji: [String]
    var numberOfCards: Int
    var color: UIColor.RGB
    
    func getColor() -> Color {
        Color(color)
    }
}
