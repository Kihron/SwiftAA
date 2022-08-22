//
//  ProgressBarView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/20/22.
//

import SwiftUI

struct ProgressBarView: View {
    @EnvironmentObject var settings: AppSettings
    @Binding var value: Int
    @State var total: Int
    @State var title: String
    @Binding var message: String
    @State var isToolbar: Bool
    
    init(value: Binding<Int>, total: Int, title: String, message: Binding<String> = .constant(""), isToolbar: Bool = false) {
        _value = value
        self.total = total
        self.title = title
        _message = message
        self.isToolbar = isToolbar
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(value) / \(total) \(title) (\(value * 100 / total)%)\(message)")
                .font(.custom("Minecraft-Regular", size: 10))
                .foregroundColor(isToolbar ? Color.primary :  settings.textColor)
            
            GeometryReader { item in
                ZStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Image("bar_ender_dragon_inactive_left")
                        Image("bar_ender_dragon_inactive_middle")
                            .resizable()
                            .frame(width: max(0,  CGFloat(Int(item.size.width) - 40)), height: 10)
                        Image("bar_ender_dragon_inactive_right")
                    }
                    
                    HStack(spacing: 0) {
                        if (value > 0) {
                            Image("bar_ender_dragon_active_left")
                            Image("bar_ender_dragon_active_middle")
                                .resizable()
                                .frame(width: CGFloat(max(0, (Int(item.size.width) * value / total) - (value >= total ? 40 : 20))), height: 10)
                            if (value >= total) {
                                Image("bar_ender_dragon_active_right")
                            }
                        }
                    }
                }
            }
            .frame(height: 10)
        }
        .padding(5)
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        ProgressBarView(value: .constant(0), total: 42, title: "Biomes Visited")
            .frame(width: 400, height: 100)
            .environmentObject(settings)
    }
}
