//
//  DonationView.swift
//  SwiftAA
//
//  Created by Kihron on 8/25/22.
//

import SwiftUI

struct DonationView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var settings: AppSettings
    @State private var window: NSWindow?
    @State var show = false
    
    var body: some View {
        Button {
            openURL(URL(string: "https://ko-fi.com/kscode")!)
        } label: {
            ZStack {
                Rectangle()
                    .fill(settings.backgroudColor)
                    .overlay {
                        Rectangle()
                            .fill(.clear)
                            .border(settings.borderColor, width: 2)
                            .frame(width: 200, height: 50)
                    }
                    .shadow(color: settings.borderColor, radius: 3, x: 0, y: 0)
                
                HStack {
                    Image("enchantment_table")
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 32, height: 32)
                        
                    Text("donate-message")
                        .font(.custom("Minecraft-Regular", size: 12))
                        .foregroundColor(settings.textColor)
                    }
            }
            .frame(width: 200, height: 50)
        }
        .buttonStyle(.plain)
    }
}

struct DonationView_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        DonationView()
            .frame(width: 300, height: 300)
            .environmentObject(settings)
    }
}
