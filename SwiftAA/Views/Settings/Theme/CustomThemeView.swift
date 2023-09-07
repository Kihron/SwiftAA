//
//  CustomThemeView.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

struct CustomThemeView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 1)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(.gray.opacity(0.1))
            
            Image(systemName: "plus")
                .font(.title)
        }
        .frame(width: 100, height: 67)
    }
}

#Preview {
    CustomThemeView()
        .padding()
}
