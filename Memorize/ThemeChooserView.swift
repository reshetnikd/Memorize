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
    
    // MARK: - Drawing Constants
    
    private let popoverWidth: CGFloat = 400
    private let popoverHeight: CGFloat = 530
    
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
                                        .popover(item: $editItem) { theme in
                                            ThemeEditor(theme: theme)
                                                .environmentObject(store)
                                                .frame(minWidth: 0, idealWidth: popoverWidth, maxWidth: .infinity, minHeight: 0, idealHeight: popoverHeight, maxHeight: .infinity, alignment: .center)
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
            }
            .navigationBarTitle(Text("Memorize"))
            .navigationBarItems(
                leading: Button(action: {
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
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: ThemeStore
    @State private var themeName = ""
    @State private var emojis = ""
    @State private var cardsCount = 2
    @State private var isEditing = false
    @State var theme: Theme
    
    // MARK: - Drawing Constants
    
    private let fontSize: CGFloat = 40
    private let additionalFontSize: CGFloat = 10
    private let itemsCount: Int = 5
    
    var body: some View {
        VStack {
            ZStack {
                Text(theme.name)
                    .fontWeight(.bold)
                HStack {
                    Spacer()
                    Button(action: {
                        if !themeName.isEmpty {
                            theme.name = themeName
                        }
                        if let index = store.themes.firstIndex(matching: theme) {
                            store.themes[index] = theme
                        }
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                    })
                }
            }
            .padding()
            Form {
                TextField("Theme Name", text: $themeName)
                Section(header: Text("Add Emoji")) {
                    HStack {
                        TextField("Emoji", text: $emojis)
                        Button(action: {
                            if !emojis.isEmpty {
                                emojis.forEach { emoji in
                                    if !theme.emoji.contains(String(emoji)) {
                                        theme.emoji.append(String(emoji))
                                    }
                                }
                            }
                        }, label: {
                            Text("Add")
                        })
                    }
                }
                Section(header: HStack {
                    Text("Emojis")
                    Spacer()
                    Text("tap emoji to exclude")
                        .font(Font.system(size: additionalFontSize))
                }) {
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: itemsCount)
                    LazyVGrid(columns: columns) {
                        ForEach(theme.emoji, id: \.self) { emoji in
                            Text(emoji)
                                .font(Font.system(size: fontSize))
                                .onTapGesture {
                                    if theme.emoji.count >= 3 {
                                        theme.emoji.removeAll { $0 == emoji }
                                        if theme.numberOfCards >= theme.emoji.count {
                                            theme.numberOfCards = theme.emoji.count
                                        }
                                    }
                                }
                        }
                    }
                }
                Section(header: Text("Card Count")) {
                    Stepper("\(theme.numberOfCards) Pairs", value: $cardsCount, in: 2...theme.emoji.count, step: 1) { _ in
                        theme.numberOfCards = cardsCount
                    }
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
