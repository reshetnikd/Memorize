//
//  ThemeStore.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 31.03.2021.
//

import SwiftUI
import Combine

class ThemeStore: ObservableObject {
    static let key = "SavedThemes"
    private var autosave: AnyCancellable?
    
    @Published var themes = [
        Theme(name: "Helloween", emoji: ["👻","🎃","😈","💀","🧛🏻‍♂️","🦇","🕸","🕷"], numberOfCards: 8, color: UIColor.RGB(red: 253/255, green: 141/255, blue: 14/255, alpha: 1.0)),
        Theme(name: "Sports", emoji: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉"], numberOfCards: 8, color: UIColor.RGB(red: 16/255, green: 107/255, blue: 255/255, alpha: 1.0)),
        Theme(name: "Animals", emoji: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐵","🦁"], numberOfCards: 10, color: UIColor.RGB(red: 48/255, green: 211/255, blue: 59/255, alpha: 1.0)),
        Theme(name: "Faces", emoji: ["😁","😊","😅","😆","😂","😎","🤪","🤓","🥳","😋"], numberOfCards: 10, color: UIColor.RGB(red: 254/255, green: 207/255, blue: 15/255, alpha: 1.0)),
        Theme(name: "Fruits", emoji: ["🍏","🍐","🍊","🍋","🍌","🍉","🍓","🍑","🥭","🍒"], numberOfCards: 10, color: UIColor.RGB(red: 175/255, green: 57/255, blue: 238/255, alpha: 1.0)),
        Theme(name: "Flowers", emoji: ["💐","🌷","🌹","🥀","🌺","🌸","🌼","🌻"], numberOfCards: 8, color: UIColor.RGB(red: 252/255, green: 26/255, blue: 77/255, alpha: 1.0))
    ]
    
    init() {
        themes = UserDefaults.standard.object(forKey: ThemeStore.key) as? [Theme] ?? []
        autosave = $themes.sink { themes in
            UserDefaults.standard.set(themes, forKey: ThemeStore.key)
        }
    }
}
