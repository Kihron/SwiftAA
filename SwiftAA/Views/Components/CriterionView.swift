//
//  CriterionView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

struct CriterionView: View {
    @Binding var criterion: Criterion
    
    var body: some View {
        HStack {
            if (isAnimated(icon: criterion.icon)) {
                QLImage(criterion.icon)
                    .frame(width: 16, height: 16)
            } else {
                Image(criterion.icon)
                    .frame(width: 16, height: 16)
            }
            
            Text(calculateText())
                .font(.custom("Minecraft-Regular", size: 10))
        }
        .opacity(criterion.completed ? 1 : 0.3)

    }
    
    func isAnimated(icon: String) -> Bool {
        return ["enchant_item", "enchanted_golden_apple", "summon_wither"].contains(icon)
    }
    
    func calculateText() -> String {
        let text = criterion.key.localized(value: criterion.name).capitalized
        if (Locale.current.languageCode != "en") {
            return (text.count > 14) ? String("\(String(text.prefix(13)).trimmingCharacters(in: .whitespaces))...") : text
        } else {
            return text
        }
    }
}

struct CriterionView_Previews: PreviewProvider {
    static var previews: some View {
        CriterionView(criterion: .constant(Criterion(id: "plains", key: "adventure-biomes-visited-wooded-badlands-plateau", name: "Plains", icon: "plains", completed: false)))
    }
}
