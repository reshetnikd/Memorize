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
                        .environmentObject(store)
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
    @State private var themeName = ""
    @State private var emojis = ""
    @State private var cardsCount = 2
    @State private var isEditing = false
    @State var theme: Theme
    
    var body: some View {
        VStack {
            ZStack {
                Text(theme.name)
                    .fontWeight(.bold)
                HStack {
                    Spacer()
                    Button(action: {
                        // TODO: - Save theme to store.
                    }, label: {
                        Text("Done")
                    })
                }
            }
            .padding()
            Form {
                TextField("Theme Name", text: $themeName) { isEditing in
                    self.isEditing = isEditing
                } onCommit: {
                    theme.name = themeName
                }
                Section(header: Text("Add Emoji")) {
                    HStack {
                        TextField("Emoji", text: $emojis)
                        Button(action: {
                            // TODO: - Save emoji to store.
                        }, label: {
                            Text("Add")
                        })
                    }
                }
                Section(header: HStack {
                    Text("Emojis")
                    Spacer()
                    Text("tap emoji to exclude")
                        .font(Font.system(size: 10))
                }) {
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)
                    LazyVGrid(columns: columns) {
                        ForEach(theme.emoji, id: \.self) { emoji in
                            Text(emoji)
                                .font(Font.system(size: 40))
                                .onTapGesture {
                                    // TODO: - Remove emoji.
                                }
                        }
                    }
                }
                Section(header: Text("Card Count")) {
                    Stepper("\(cardsCount) Pairs", value: $cardsCount, in: 2...theme.emoji.count)
                }
            }
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
        ThemeEditor(theme: previewTheme)
    }
}
