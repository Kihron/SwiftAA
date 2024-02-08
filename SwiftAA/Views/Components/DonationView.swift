//
//  DonationView.swift
//  SwiftAA
//
//  Created by Kihron on 8/25/22.
//

import SwiftUI

struct DonationView: View {
    @Environment(\.openURL) var openURL
    @ObservedObject var themeManager = ThemeManager.shared
    @State private var window: NSWindow?
    @State var show = false
    
    var body: some View {
        Button {
            openURL(URL(string: "https://ko-fi.com/kscode")!)
        } label: {
            ZStack {
                Rectangle()
                    .fill(themeManager.background)
                    .overlay {
                        Rectangle()
                            .fill(.clear)
                            .border(themeManager.border, width: 2)
                            .frame(width: 200, height: 50)
                    }
                    .shadow(color: themeManager.border, radius: 3, x: 0, y: 0)
                
                HStack {
                    Image("enchantment_table")
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 32, height: 32)
                        
                    Text(L10n.Donate.message)
                        .font(.custom("Minecraft-Regular", size: 12))
                        .foregroundColor(themeManager.text)
                    }
            }
            .frame(width: 200, height: 50)
        }
        .buttonStyle(.plain)
    }
}

struct DonationView_Previews: PreviewProvider {
    static var previews: some View {
        DonationView()
            .frame(width: 300, height: 300)
    }
}
