//
//  CriterionView.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI

struct CriterionView: View {
    @EnvironmentObject var settings: AppSettings
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
                .foregroundColor(settings.textColor)
        }
        .opacity(criterion.completed ? 1 : 0.3)

    }
    
    func isAnimated(icon: String) -> Bool {
        ["enchant_item", "enchanted_golden_apple", "summon_wither", "skulk_sensor"].contains(icon)
    }
    
    func calculateText() -> String {
        let text = criterion.key.localized(value: criterion.name).capitalized
        if (Locale.current.language.languageCode?.identifier != "en") {
            return (text.count > 14) ? String("\(String(text.prefix(13)).trimmingCharacters(in: .whitespaces))...") : text
        } else {
            return text
        }
    }
}

struct CriterionView_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        CriterionView(criterion: .constant(Criterion(id: "plains", key: "adventure-biomes-visited-wooded-badlands-plateau", name: "Plains", icon: "plains", completed: false)))
            .environmentObject(settings)
    }
}
