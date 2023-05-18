//
//  SSSegmentedControlButton.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct SSSegmentedControlButton: View {
    @Binding var selectedIndex: Int
    var index: Int
    var text: String
    
    var body: some View {
        Button(action: {
            selectedIndex = index
        }) {
            Text(text)
                .foregroundColor(.primary)
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(SSColors.blue.opacity(selectedIndex == index ? 1 : 0.3), lineWidth: 1)
                )
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(SSColors.blueInactive.opacity(selectedIndex == index ? 1 : 0))
                )
        }
    }
}

struct SSSegmentedControlButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SSSegmentedControlButton(selectedIndex: .constant(0), index: 0, text: "a")
            SSSegmentedControlButton(selectedIndex: .constant(0), index: 1, text: "b")
        }
    }
}
