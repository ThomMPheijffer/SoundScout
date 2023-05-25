//
//  PrimaryNavigationButtonText.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct SSPrimaryNavigationButtonText: View {
    let text: String
    let fullWidth: Bool
    
    init(text: String, fullWidth: Bool = true) {
        self.text = text
        self.fullWidth = fullWidth
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding(.horizontal)
            .frame(height: 40)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(SSColors.blue)
            )
    }
}

struct PrimaryNavigationButtonText_Previews: PreviewProvider {
    static var previews: some View {
        SSPrimaryNavigationButtonText(text: "Continue")
    }
}
