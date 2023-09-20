//
//  NotesPanelView.swift
//  SwiftAA
//
//  Created by Kihron on 7/23/22.
//

import SwiftUI

struct NotesPanelView: View {
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var noteManager = NoteManager.shared
    @State private var notes = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(L10n.Notes.Panel.View.Top.title)
                    .font(.custom("Minecraft-Regular", size: 12))
                
                VStack(spacing: 5) {
                    WayPointCardView(index: 0, icon: "elder_guardian")
                    WayPointCardView(index: 1, icon: "pillager")
                    WayPointCardView(index: 2, icon: "silverfish")
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(alignment: .leading) {
                Text(L10n.Notes.Panel.View.Bottom.title)
                    .font(.custom("Minecraft-Regular", size: 12))
                
                TextEditor(text: $notes)
                    .font(.custom("Minecraft-Regular", size: 10))
                    .cornerRadius(5)
                    .padding(.bottom, 15)
                    .disabled(trackerManager.worldPath.isEmpty)
            }
        }
        .padding()
        .applyThemeModifiers()
        .onAppear {
            if (!trackerManager.worldPath.isEmpty) {
                if let worldNotes = noteManager.notes[trackerManager.worldPath] {
                    self.notes = worldNotes[3]
                }
            }
        }
        .onChange(of: trackerManager.worldPath) { path in
            if (!path.isEmpty) {
                self.notes = noteManager.notes[path]?[3] ?? ""
            } else {
                notes = ""
            }
        }
        .onChange(of: notes) { note in
            noteManager.notes[trackerManager.worldPath, default: [",", ",", ",", ""]][3] = notes
        }
        .onDisappear {
            if (!trackerManager.worldPath.isEmpty) {
                noteManager.notes[trackerManager.worldPath, default: [",", ",", ",", ""]][3] = notes
            }
        }
    }
}

struct WayPointCardView: View {
    @ObservedObject private var themeManager = UIThemeManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var noteManager = NoteManager.shared
    @State var index: Int
    @State var icon: String
    @State var x: String = ""
    @State var z: String = ""
    
    var body: some View {
        HStack {
            Image(icon)
                .interpolation(.none)
                .resizable()
                .frame(width: 32, height: 32)
            
            VStack(spacing: 5) {
                HStack {
                    TextField("", text: $x, prompt: Text("X"))
                        .font(.custom("Minecraft-Regular", size: 10))
                        .disabled(trackerManager.worldPath.isEmpty)
                        .background(Color("frame_modern_background"))
                        .roundedCorners(radius: 2, corners: [.allCorners])
                    
                    TextField("", text: $z, prompt: Text("Z"))
                        .font(.custom("Minecraft-Regular", size: 10))
                        .disabled(trackerManager.worldPath.isEmpty)
                        .background(Color("frame_modern_background"))
                        .roundedCorners(radius: 2, corners: [.allCorners])
                }
                
                HStack {
                    ZStack {
                        Text(x.toNether)
                            .font(.custom("Minecraft-Regular", size: 10))
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 4)
                            .background(.red.opacity(0.5))
                            .roundedCorners(radius: 2, corners: [.allCorners])
                    }
                    
                    ZStack {
                        Text(z.toNether)
                            .font(.custom("Minecraft-Regular", size: 10))
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 4)
                            .background(.red.opacity(0.5))
                            .roundedCorners(radius: 2, corners: [.allCorners])
                    }
                }
                .applyThemeText()
            }
        }
        .onAppear {
            if (!trackerManager.worldPath.isEmpty) {
                if let worldNotes = noteManager.notes[trackerManager.worldPath] {
                    let coords = worldNotes[index].components(separatedBy: ",")
                    self.x = String(coords[0])
                    self.z = String(coords[1])
                }
            }
        }
        .onChange(of: trackerManager.worldPath) { path in
            if (!path.isEmpty) {
                if let worldNotes = noteManager.notes[path] {
                    let coords = worldNotes[index].components(separatedBy: ",")
                    self.x = String(coords[0])
                    self.z = String(coords[1])
                } else {
                    x = ""
                    z = ""
                }
            } else {
                x = ""
                z = ""
            }
        }
        .onChange(of: x) { note in
            noteManager.notes[trackerManager.worldPath, default: [",", ",", ",", ""]][index] = "\(x),\(z)"
        }
        .onChange(of: z) { note in
            noteManager.notes[trackerManager.worldPath, default: [",", ",", ",", ""]][index] = "\(x),\(z)"
        }
        .onDisappear {
            if (!trackerManager.worldPath.isEmpty) {
                noteManager.notes[trackerManager.worldPath, default: [",", ",", ",", ""]][index] = "\(x),\(z)"
            }
        }
    }
}

private extension String {
    var toNether: String {
        get {
            if let num = Int(self) {
                return String((num / 8) - (num < 0 ? 1 : 0))
            } else {
                return "?"
            }
        }
        set {}
    }
}

struct NotesPanelView_Previews: PreviewProvider {
    static var previews: some View {
        NotesPanelView()
            .frame(width: 300, height: 800)
    }
}
