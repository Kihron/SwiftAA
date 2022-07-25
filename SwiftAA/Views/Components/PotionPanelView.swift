//
//  PotionPanelView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/20/22.
//

import SwiftUI

struct PotionPanelView: View {
    var body: some View {
        VStack(spacing: 0) {
            PotionView(name: "Strength", ingredients: ["nether_wart", "blaze_powder"])
            PotionView(name: "Weakness", ingredients: ["fermented_spider_eye"])
            PotionView(name: "Swiftness", ingredients: ["nether_wart", "sugar"])
            PotionView(name: "Slowness", ingredients: ["nether_wart", "sugar", "fermented_spider_eye"])
            PotionView(name: "Night Vision", ingredients: ["nether_wart", "golden_carrot"])
            PotionView(name: "Invisibility", ingredients: ["nether_wart", "golden_carrot", "fermented_spider_eye"])
            PotionView(name: "Leaping", ingredients: ["nether_wart", "rabbit_foot"])
            PotionView(name: "Slow Falling", ingredients: ["nether_wart", "phantom_membrane"])
            PotionView(name: "Water Breathing", ingredients: ["nether_wart", "pufferfish"])
        }
    }
}

struct PotionView: View {
    @State var name: String
    @State var ingredients: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Potion of \(name)")
                .font(.custom("Minecraft-Regular", size: 10))
            
            HStack(spacing: 0) {
                Image("potion_\(name.replacingOccurrences(of: " ", with: "_").lowercased())")
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                
                Image("arrow")
                    .renderingMode(.template)
                    .foregroundColor(Color("ender_pearl_border"))
                
                ForEach(ensureCapacity(ingredients), id: \.self) { item in
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
        .background(Color("ender_pearl_background"))
        .border(Color("ender_pearl_border"), width: 2)
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

//struct PotionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PotionView(name: "Strength", ingredients: ["nether_wart", "blaze_powder"])
//            .frame(width: 400, height: 100)
//    }
//}
