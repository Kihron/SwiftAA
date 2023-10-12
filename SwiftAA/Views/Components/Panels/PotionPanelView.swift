//
//  PotionPanelView.swift
//  SwiftAA
//
//  Created by Kihron on 7/20/22.
//

import SwiftUI

struct PotionPanelView: View {
    @ObservedObject private var themeManager = UIThemeManager.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(Potion.allCases) { potion in
                    PotionView(name: potion.name, ingredients: potion.ingredients)
                        .applyThemeModifiers()
                }
            }
            .frame(height: 431)
        }
        .applyThemeModifiers()
    }
}

struct PotionView: View {
    @ObservedObject private var themeManager = UIThemeManager.shared
    @State var name: String
    @State var ingredients: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("potion.\(name)".localized)
                .font(.custom("Minecraft-Regular", size: 10))
            
            HStack(spacing: 0) {
                Image("potion_\(name)")
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                
                Image("arrow")
                    .renderingMode(.template)
                    .foregroundColor(themeManager.border)
                
                HStack(spacing: 0) {
                    ForEach(ensureCapacity(ingredients).indices, id: \.self) { index in
                        let item = ensureCapacity(ingredients)[index]
                        if (!item.isEmpty) {
                            Image(item)
                                .interpolation(.none)
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                        else {
                            Rectangle()
                                .fill(.clear)
                                .frame(width: 32, height: 32)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(1.95)
    }
    
    func ensureCapacity(_ ingredients: [String]) -> [String] {
        var ingredients = ingredients
        while ingredients.count < 3 {
            ingredients.append("")
        }
        return ingredients
    }
}

struct PotionPanelView_Previews: PreviewProvider {
    static var previews: some View {
        PotionPanelView()
            .frame(width: 300, height: 800)
    }
}
