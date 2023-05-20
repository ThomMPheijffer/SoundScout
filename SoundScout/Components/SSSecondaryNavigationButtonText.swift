//
//  SSSecondaryNavigationButtonText.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct SSSecondaryNavigationButtonText: View {
    let text: String
    let paddingValue: CGFloat
    
    var body: some View {
        Text(text)
            .padding(.horizontal, paddingValue)
            .foregroundColor(.primary)
            .frame(height: 32)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(SSColors.blue, lineWidth: 1)
            )
    }
}

struct SSSecondaryNavigationButtonText_Previews: PreviewProvider {
    
    static var previews: some View {
        SSSecondaryNavigationButtonText(text: "Login", paddingValue: 32)
    }
}
