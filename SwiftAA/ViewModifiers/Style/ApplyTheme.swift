//
//  ApplyTheme.swift
//  SwiftAA
//
//  Created by Kihron on 9/4/23.

import SwiftUI

struct ApplyTheme: ViewModifier {
    @ObservedObject var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        content
            .background(themeManager.background)
            .foregroundStyle(themeManager.text)
            .border(themeManager.border, width: 1)
    }
}

struct ApplyThemeText: ViewModifier {
    @ObservedObject var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        content
            .foregroundStyle(themeManager.text)
    }
}

struct ApplyThemeBackgrounds: ViewModifier {
    @ObservedObject var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        content
            .background(themeManager.background)
            .border(themeManager.border, width: 1)
    }
}

extension View {
    func applyThemeModifiers() -> some View {
        self.modifier(ApplyTheme())
    }
    
    func applyThemeText() -> some View {
        self.modifier(ApplyThemeText())
    }
    
    func applyThemeBackgroundAndBorder() -> some View {
        self.modifier(ApplyThemeBackgrounds())
    }
}
