//
//  SSCheckbox.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/05/2023.
//

import SwiftUI

struct SSCheckbox: View {
    @Binding var isEnabled: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(SSColors.blue.opacity(isEnabled ? 1 : 0))
                .frame(width: 18, height: 18)

            Circle()
                .strokeBorder(SSColors.blue, lineWidth: 3)
                .frame(width: 26, height: 26)
        }
    }
}

struct SSCheckbox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SSCheckbox(isEnabled: .constant(true))
            SSCheckbox(isEnabled: .constant(false))
        }
    }
}
