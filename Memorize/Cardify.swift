//
//  Cardify.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 03.03.2021.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.7
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
            }
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
