//
//  SSSecondaryNavigationButtonText.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct SSSecondaryNavigationButtonText: View {
    let text: String
    let fullWidth: Bool
    
    init(text: String, fullWidth: Bool = false) {
        self.text = text
        self.fullWidth = fullWidth
    }
    
    var body: some View {
        Text(text)
            .padding(.horizontal, 32)
            .foregroundColor(.primary)
            .frame(height: 40)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(SSColors.blue, lineWidth: 1)
            )
    }
}

struct SSSecondaryNavigationButtonText_Previews: PreviewProvider {
    
    static var previews: some View {
        SSSecondaryNavigationButtonText(text: "Login")
    }
}
