//
//  UserTheme.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/5/23.
//

import SwiftUI

struct UserTheme: Codable {
    var backgroundColor: Color
    var borderColor: Color
    var textColor: Color
}

extension UserTheme {
    static let initial = UserTheme(backgroundColor: Color("ender_pearl_background"), borderColor: Color("ender_pearl_border"), textColor: Color("ender_pearl_text"))
}
