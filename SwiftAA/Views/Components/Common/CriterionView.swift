//
//  CriterionView.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI

struct CriterionView: View {
    @Binding var criterion: Criterion
    
    var body: some View {
        HStack {
            Image(criterion.icon)
                .frame(width: 16, height: 16)
            
            Text(calculateText())
                .minecraftFont()
                .applyThemeText()
        }
        .opacity(criterion.completed ? 1 : 0.3)
    }
    
    func calculateText() -> String {
        let text = criterion.key.localized(value: criterion.name).capitalized
        if let languageCode = Locale.preferredLanguages.first, !languageCode.hasPrefix("en") {
            return (text.count > 14) ? String("\(String(text.prefix(13)).trimmingCharacters(in: .whitespaces))...") : text
        } else {
            return text
        }
    }
}

struct CriterionView_Previews: PreviewProvider {
    static var previews: some View {
        CriterionView(criterion: .constant(Criterion(id: "plains", key: "adventure-biomes-visited-wooded-badlands-plateau", name: "Plains", icon: "plains")))
            .padding()
    }
}
