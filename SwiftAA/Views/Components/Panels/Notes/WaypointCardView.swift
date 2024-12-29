//
//  WaypointCardVeiw.swift
//  SwiftAA
//
//  Created by Kihron on 9/26/23.
//

import SwiftUI

struct WaypointCardView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var themeManager = ThemeManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var noteManager = NoteManager.shared
    
    @Binding var note: Note
    
    @State var index: Int
    @State var icon: String
    
    @State private var x: String = ""
    @State private var z: String = ""
    
    var body: some View {
        HStack {
            Image(icon)
                .interpolation(.none)
                .resizable()
                .frame(width: 32, height: 32)
            
            VStack(spacing: 5) {
                HStack {
                    TextField("", text: $x, prompt: Text("X"))
                        .minecraftFont()
                        .disabled(trackerManager.worldPath.isEmpty)
                        .background(Color("frame_modern_background"))
                        .roundedCorners(radius: 2, corners: [.allCorners])
                    
                    TextField("", text: $z, prompt: Text("Z"))
                        .minecraftFont()
                        .disabled(trackerManager.worldPath.isEmpty)
                        .background(Color("frame_modern_background"))
                        .roundedCorners(radius: 2, corners: [.allCorners])
                }
                
                HStack {
                    ZStack {
                        Text(x.toNether)
                            .minecraftFont()
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 4)
                            .background(.red.opacity(0.5))
                            .roundedCorners(radius: 2, corners: [.allCorners])
                    }
                    
                    ZStack {
                        Text(z.toNether)
                            .minecraftFont()
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
            withAnimation {
                loadWaypoint()
            }
        }
        .onChange(of: note.path) { _ in
            withAnimation {
                loadWaypoint()
            }
        }
        .onChange(of: x) { value in
            if let copiedText = NSPasteboard.general.string(forType: .string), copiedText == value {
                checkF3C(input: value)
            }
            
            saveWaypoint()
            noteManager.updateNote(note: note, context: context)
        }
        .onChange(of: z) { value in
            if let copiedText = NSPasteboard.general.string(forType: .string), copiedText == value {
                checkF3C(input: value)
            }
            
            saveWaypoint()
            noteManager.updateNote(note: note, context: context)
        }
    }
    
    private func checkF3C(input: String) {
        let pattern = #"\s(-?\d+\.\d+)\s(-?\d+\.\d+)\s(-?\d+\.\d+)\s"#

        if let match = input.range(of: pattern, options: .regularExpression) {
            let start = match.lowerBound
            let end = match.upperBound
            let coordinatesSubstring = input[start..<end]
            
            let coordinatesArray = coordinatesSubstring.split(separator: " ")
            if coordinatesArray.count >= 2 {
                if let x = Double(coordinatesArray[0]), let z = Double(coordinatesArray[2]) {
                    self.x = String(Int(x))
                    self.z = String(Int(z))
                }
            }
        }
    }
    
    private func saveWaypoint() {
        let value = x + String(repeating: " ", count: max(x.count, z.count) - min(x.count, z.count)) + z
        
        switch index {
            case 0:
                note.monument = value
            case 1:
                note.outpost = value
            default:
                note.stronghold = value
        }
    }
    
    private func loadWaypoint() {
        let value: String
        switch index {
            case 0:
                value = note.monument
            case 1:
                value = note.outpost
            default:
                value = note.stronghold
        }
        
        let mid = value.count / 2
        x = value.dropLast(mid).trimmingCharacters(in: .whitespaces)
        z = value.dropFirst(mid).trimmingCharacters(in: .whitespaces)
    }
}

extension String {
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
