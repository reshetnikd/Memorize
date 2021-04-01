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
    @State private var editItem: Theme?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes, id: \.self) { theme in
                    NavigationLink(
                        destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(usingTheme: theme))
                            .navigationTitle(theme.name),
                        label: {
                            HStack {
                                if editMode.isEditing {
                                    Image(systemName: "pencil.circle")
                                        .imageScale(.large)
                                        .onTapGesture {
                                            editItem = theme
                                        }
                                }
                                ThemeItem(theme)
                            }
                        }
                    )
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .popover(item: $editItem) { theme in
                    ThemeEditor(theme: theme)
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
    @State var theme: Theme
    
    var body: some View {
        Form {
            TextField("Theme Name", text: $theme.name)
        }
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
        ThemeEditor(theme: previewTheme)
    }
}
