//
//  UserTheme.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

struct UserTheme: Identifiable, Codable, Theme {
    var id: UUID
    var name: String
    var backgroundColor: Color
    var borderColor: Color
    var textColor: Color
}

extension UserTheme {
    static let initial = UserTheme(id: UUID(), name: "Ender Pearl", backgroundColor: Color("ender_pearl_background"), borderColor: Color("ender_pearl_border"), textColor: Color("ender_pearl_text"))
}
