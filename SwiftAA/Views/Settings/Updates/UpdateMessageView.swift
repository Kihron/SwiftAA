//
//  UpdateMessageView.swift
//  SwiftAA
//
//  Created by Kihron on 3/7/24.
//

import SwiftUI

struct UpdateMessageView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var updateManager = UpdateManager.shared
    
    var title: String
    
    private var appVersion: String {
        return updateManager.appVersion ?? ""
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title) • v\(appVersion)")
                .font(.title2)
                .fontWeight(.bold)
            
            SettingsCardView(padding: 0) {
                VStack {
                    if !updateManager.releaseNotes.isEmpty {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 14) {
                                ForEach(updateManager.releaseNotes) { entry in
                                    if entry.tagName.dropFirst() == appVersion {
                                        UpdateReleaseEntryView(title: L10n.Updater.ReleaseNotes.currentRelease, releaseEntry: entry)
                                    } else {
                                        UpdateReleaseEntryView(releaseEntry: entry)
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    } else {
                        Text(L10n.Updater.ReleaseNotes.none)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            
            Button(action: { dismiss() }) {
                Text(L10n.Button.close)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .frame(width: 500, height: 300)
    }
}

#Preview {
    UpdateMessageView(title: L10n.Updater.ReleaseNotes.appUpdated)
}
