//
//  NotesPanelView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/23/22.
//

import SwiftUI

struct NotesPanelView: View {
    @EnvironmentObject var settings: AppSettings
    @State var notes = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("notes-panel-view-top-title", comment: "Title: Waypoint Menu")
                    .font(.custom("Minecraft-Regular", size: 12))
                
                VStack(spacing: 5) {
                    WayPointCardView(index: 0, icon: "elder_guardian")
                    WayPointCardView(index: 1, icon: "pillager")
                    WayPointCardView(index: 2, icon: "silverfish")
                }
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("notes-panel-view-bottom-title", comment: "Title: Notes Menu")
                    .font(.custom("Minecraft-Regular", size: 12))
                
                TextEditor(text: $notes)
                    .font(.custom("Minecraft-Regular", size: 10))
                    .cornerRadius(5)
                    .padding(.bottom, 5)
                    .disabled(settings.worldPath.isEmpty)
                
                Spacer()
                
                HStack {
                    Spacer()
                }
            }
        }
        .padding()
        .background(settings.backgroudColor)
        .border(settings.borderColor, width: 2)
        .onAppear {
            if (!settings.worldPath.isEmpty) {
                if let worldNotes = settings.notes[settings.worldPath] {
                    self.notes = worldNotes[3]
                }
            }
        }
        .onChange(of: settings.worldPath) { path in
            if (!path.isEmpty) {
                self.notes = settings.notes[path]?[3] ?? ""
            } else {
                notes = ""
            }
        }
        .onChange(of: notes) { note in
            settings.notes[settings.worldPath, default: [",", ",", ",", ""]][3] = notes
        }
        .onDisappear {
            if (!settings.worldPath.isEmpty) {
                settings.notes[settings.worldPath, default: [",", ",", ",", ""]][3] = notes
            }
        }
    }
}

struct WayPointCardView: View {
    @EnvironmentObject var settings: AppSettings
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
                    TextField("X", text: $x)
                            .font(.custom("Minecraft-Regular", size: 10))
                            .disabled(settings.worldPath.isEmpty)
                    
                    TextField("Z", text: $z)
                            .font(.custom("Minecraft-Regular", size: 10))
                            .disabled(settings.worldPath.isEmpty)
                }
                
                HStack {
                    TextField("", text: $x.toNether)
                            .font(.custom("Minecraft-Regular", size: 10))
                            .disabled(true)
                            .background(.red.opacity(0.5))
                            .foregroundColor(.white)
                    
                    TextField("", text: $z.toNether)
                            .font(.custom("Minecraft-Regular", size: 10))
                            .disabled(true)
                            .background(.red.opacity(0.5))
                            .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            if (!settings.worldPath.isEmpty) {
                if let worldNotes = settings.notes[settings.worldPath] {
                    let coords = worldNotes[index].components(separatedBy: ",")
                    self.x = String(coords[0])
                    self.z = String(coords[1])
                }
            }
        }
        .onChange(of: settings.worldPath) { path in
            if (!path.isEmpty) {
                if let worldNotes = settings.notes[path] {
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
            settings.notes[settings.worldPath, default: [",", ",", ",", ""]][index] = "\(x),\(z)"
        }
        .onChange(of: z) { note in
            settings.notes[settings.worldPath, default: [",", ",", ",", ""]][index] = "\(x),\(z)"
        }
        .onDisappear {
            if (!settings.worldPath.isEmpty) {
                settings.notes[settings.worldPath, default: [",", ",", ",", ""]][index] = "\(x),\(z)"
            }
        }
    }
}

private extension String {
    var toNether: String {
        get {
            if let num = Int(self) {
                return String(num / 8)
            } else {
                return "?"
            }
        }
        set {}
    }
}

struct NotesPanelView_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        NotesPanelView()
            .frame(width: 300, height: 800)
            .environmentObject(settings)
        
        WayPointCardView(index: 0, icon: "silverfish")
            .padding(4)
            .environmentObject(settings)
    }
}
