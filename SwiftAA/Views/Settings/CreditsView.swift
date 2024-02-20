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
                    HStack {
                        CachedAsyncImage(url: getAvatarURL("Kihron")) { image in
                            image
                        } placeholder: {
                            Image("Kihron")
                        }
                        .frame(width: 32)
                        
                        Text("Kihron - Developer")
                        
                        Image(systemName: "wrench.adjustable.fill")
                            .foregroundStyle(.teal)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        CachedAsyncImage(url: getAvatarURL("Slackow")) { image in
                            image
                        } placeholder: {
                            Image("Slackow")
                        }
                        .frame(width: 32)
                        
                        Text("Slackow - Developer")
                        
                        Image(systemName: "wrench.adjustable.fill")
                            .foregroundStyle(.orange)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        CachedAsyncImage(url: getAvatarURL("nealxm")) { image in
                            image
                        } placeholder: {
                            Image("nealxm")
                        }
                        .frame(width: 32)
                        
                        Text("nealxm - Beta Tester")
                        
                        Image(systemName: "atom")
                            .foregroundStyle(.green)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            SettingsLabel(title: "Attribution")
                .padding(.top, 5)
            
            SettingsCardView {
                HStack {
                    CachedAsyncImage(url: getAvatarURL("_CTM")) { image in
                        image
                    } placeholder: {
                        Image("steve_avatar")
                    }
                    .frame(width: 32)
                    
                    Image("aatool")
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 32, height: 32)
                    
                    Text(.init(L10n.Credits.attribution))
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
