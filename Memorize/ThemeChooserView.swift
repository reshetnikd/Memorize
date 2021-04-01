//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 31.03.2021.
//

import SwiftUI

struct ThemeChooserView: View {
    @EnvironmentObject var store: ThemeStore
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes, id: \.self) { theme in
                    NavigationLink(
                        destination: editMode.isEditing ? AnyView(ThemeEditor(theme).navigationTitle(theme.name)) : AnyView(EmojiMemoryGameView(viewModel: EmojiMemoryGame(usingTheme: theme)).navigationTitle(theme.name)),
                        label: {
                            ThemeItem(theme)
                        })
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle(Text("Memorize"))
            .navigationBarItems(
                leading: Button(action: {
                    // TODO: - ThemeEditor()
                    let untitled = Theme(name: "Untitled", emoji: ["👍🏻", "👎🏻"], numberOfCards: 2, color: .init(red: 0, green: 0, blue: 0, alpha: 1))
                    store.themes.append(untitled)
                }, label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
}

struct ThemeEditor: View {
    var theme: Theme
    
    var body: some View {
        Text(theme.name)
    }
    
    init(_ theme: Theme) {
        self.theme = theme
    }
}

struct ThemeItem: View {
    let theme: Theme
    
    var body: some View {
        var emojiLine: String = ""
        theme.emoji.forEach { emojiLine.append($0) }
        
        return VStack(alignment: .leading) {
            Text(theme.name)
                .fontWeight(.bold)
                .foregroundColor(theme.getColor())
            Text("\(theme.numberOfCards == theme.emoji.count ? "All of " : "\(theme.numberOfCards) pairs from ") \(emojiLine)")
        }
    }
    
    init(_ theme: Theme) {
        self.theme = theme
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previewTheme = Theme(name: "Untitled", emoji: ["👍🏻", "👎🏻"], numberOfCards: 2, color: .init(red: 0, green: 0, blue: 0, alpha: 1))
    
    static var previews: some View {
        ThemeChooserView().environmentObject(ThemeStore())
        ThemeEditor(previewTheme)
    }
}
