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
        self.currentPreset = preset
    }
    
    func selectUserTheme() {
        self.themeMode = .custom
    }
    
    //    func copyPresetToUserTheme() {
    //        userTheme.backgroundColor = currentPreset.backgroundColor
    //        userTheme.borderColor = currentPreset.borderColor
    //        userTheme.textColor = currentPreset.textColor
    //        self.themeMode = .custom
    //    }
    
    func getUserThemesFromFetch(fetch: FetchedResults<UserThemes>) {
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
            userThemes.append(UserTheme(id: uuid, name: name, backgroundColor: background, borderColor: border, textColor: text))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUserTheme(theme: UserTheme, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<UserThemes> = UserThemes.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", theme.id as CVarArg)

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
        
        userThemes.removeAll(where: { $0.id == theme.id })
    }
}

enum ThemeMode: String {
    case preset, custom
}
