//
//  PotionPanelView.swift
//  SwiftAA
//
//  Created by Kihron on 7/20/22.
//

import SwiftUI

struct PotionPanelView: View {
    var body: some View {
        VStack(spacing: 0) {
            PotionView(name: "strength", ingredients: ["nether_wart", "blaze_powder"])
            PotionView(name: "weakness", ingredients: ["fermented_spider_eye"])
            PotionView(name: "swiftness", ingredients: ["nether_wart", "sugar"])
            PotionView(name: "slowness", ingredients: ["nether_wart", "sugar", "fermented_spider_eye"])
            PotionView(name: "night-vision", ingredients: ["nether_wart", "golden_carrot"])
            PotionView(name: "invisibility", ingredients: ["nether_wart", "golden_carrot", "fermented_spider_eye"])
            PotionView(name: "leaping", ingredients: ["nether_wart", "rabbit_foot"])
            PotionView(name: "slow-falling", ingredients: ["nether_wart", "phantom_membrane"])
            PotionView(name: "water-breathing", ingredients: ["nether_wart", "pufferfish"])
        }
    }
}

struct PotionView: View {
    @EnvironmentObject var settings: AppSettings
    @State var name: String
    @State var ingredients: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("potion-\(name)".localized)
                .font(.custom("Minecraft-Regular", size: 10))
                .foregroundColor(settings.textColor)
            
            HStack(spacing: 0) {
                Image("potion_\(name.replacingOccurrences(of: "-", with: "_").lowercased())")
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                
                Image("arrow")
                    .renderingMode(.template)
                    .foregroundColor(Color("ender_pearl_border"))
                
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
                
                Spacer()
            }
        }
        .padding(1.95)
        .background(settings.backgroudColor)
        .border(settings.borderColor, width: 2)
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
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        PotionPanelView()
            .frame(width: 300, height: 800)
            .environmentObject(settings)
    }
}
