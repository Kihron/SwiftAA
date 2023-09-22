//
//  UIThemeManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/4/23.
//

import SwiftUI

class UIThemeManager: ObservableObject {
    @AppStorage("currentPreset") var currentPreset: ThemePreset = .enderPearl
    @AppStorage("selectedUserTheme") private var selectedUserTheme: UUID?
    @AppStorage("themeMode") var themeMode: ThemeMode = .preset
    
    static let shared = UIThemeManager()
    
    @Published var userThemes: [UserTheme] = []
    
    var label: String {
        return themeMode == .preset ? currentPreset.localized : userTheme.name
    }
    
    var userTheme: UserTheme {
        if let uuid = selectedUserTheme, let theme = userThemes.first(where: { $0.id == uuid }) {
            return theme
        }
        return UserTheme.initial
    }
    
    var background: Color {
        return themeMode == .preset ? currentPreset.backgroundColor : userTheme.backgroundColor
    }
    
    var border: Color {
        return themeMode == .preset ? currentPreset.borderColor : userTheme.borderColor
    }
    
    var text: Color {
        return themeMode == .preset ? currentPreset.textColor : userTheme.textColor
    }
    
    init() {
        
    }
    
    func changePreset(preset: ThemePreset) {
        withAnimation {
            self.themeMode = .preset
            self.currentPreset = preset
        }
    }
    
    func selectUserTheme(theme: UserTheme) {
        withAnimation {
            self.themeMode = .custom
            self.selectedUserTheme = theme.id
        }
    }
    
    func getUserThemesFromFetch(fetch: FetchedResults<UserThemes>) {
        userThemes.removeAll()
        for theme in fetch {
            if let uuid = theme.id, let name = theme.name, let backgroundColor = theme.backgroundColor, let borderColor = theme.borderColor, let textColor = theme.textColor {
                userThemes.append(UserTheme(id: uuid, name: name, backgroundColor: Color(rawValue: backgroundColor)!, borderColor: Color(rawValue: borderColor)!, textColor: Color(rawValue: textColor)!))
            }
        }
    }
    
    func saveUserTheme(name: String, background: Color, border: Color, text: Color, context: NSManagedObjectContext) {
        let userTheme = UserThemes(context: context)
        let uuid = UUID()
        userTheme.id = uuid
        userTheme.name = name
        userTheme.backgroundColor = background.rawValue
        userTheme.borderColor = border.rawValue
        userTheme.textColor = text.rawValue
        do {
            try context.save()
            withAnimation {
                let theme = UserTheme(id: uuid, name: name, backgroundColor: background, borderColor: border, textColor: text)
                userThemes.append(theme)
                selectUserTheme(theme: theme)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUserTheme(context: NSManagedObjectContext) {
        if let id = selectedUserTheme {
            let fetchRequest: NSFetchRequest<UserThemes> = UserThemes.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                let objects = try context.fetch(fetchRequest)
                if let object = objects.first {
                    context.delete(object)
                    try context.save()
                } else {
                    print("Object not found")
                }
            } catch {
                print("Failed to delete object")
            }
            
            withAnimation {
                let idx = userThemes.firstIndex(where: { $0.id == id })
                if let idx = idx {
                    if idx - 1 >= 0 {
                        selectUserTheme(theme: userThemes[idx - 1])
                    } else {
                        changePreset(preset: .enderPearl)
                    }
                    userThemes.remove(at: idx)
                }
            }
        }
    }
}

enum ThemeMode: String {
    case preset, custom
}
