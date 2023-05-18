//
//  PrimaryNavigationButtonText.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct SSPrimaryNavigationButtonText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
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
