//
//  CreditsView.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import SwiftUI
import CachedAsyncImage

struct CreditsView: View {
    var body: some View {
        VStack {
            SettingsCardView {
                VStack {
                    CreditsEntryView(name: "Kihron", role: L10n.Credits.Role.developer, icon: "wrench.adjustable.fill", color: .teal)
                    
                    CreditsEntryView(name: "Slackow", role: L10n.Credits.Role.developer, icon: "wrench.adjustable.fill", color: .orange)
                    
                    CreditsEntryView(name: "nealxm", role: L10n.Credits.Role.betaTester, icon: "atom", color: .green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            SettingsLabel(title: L10n.Credits.Attribution.title)
                .padding(.top, 5)
            
            SettingsCardView {
                HStack {
                    CachedAsyncImage(url: getAvatarURL("_CTM"), urlCache: .imageCache) { image in
                        image
                    } placeholder: {
                        Image("steve_avatar")
                    }
                    .frame(width: 32)
                    .clipShape(.rect(cornerRadius: 2))
                    
                    Image("aatool")
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 32, height: 32)
                    
                    Text(.init(L10n.Credits.Attribution.info))
                        .tint(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            SettingsLabel(title: L10n.Credits.Donate.title)
                .padding(.top, 5)
            
            SettingsCardView {
                HStack {
                    Image(systemName: "heart.fill")
                        .font(.title)
                        .foregroundStyle(.pink)
                    
                    Text(.init(L10n.Credits.Donate.message))
                        .tint(.pink)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
    
    private func getAvatarURL(_ name: String) -> URL? {
        return URL(string: "https://minotar.net/helm/\(name)/32")
    }
}

#Preview {
    CreditsView()
}
