//
//  SSTextField.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct SSTextField: View {
    var title: String
    @Binding var text: String
    var isSecured = false
    var axis: Axis? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title3)
                .padding(.bottom)
            
            if isSecured {
                SecureField(title, text: $text)
                    .padding(.leading, 4)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(SSColors.blue.opacity(0.3), lineWidth: 1)
                    )
            }
            
            if axis == nil {
                TextField(title, text: $text)
                    .padding(.leading, 4)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(SSColors.blue.opacity(0.3), lineWidth: 1)
                    )
            } else {
                TextField(title, text: $text, axis: axis!)
                    .padding(.leading, 4)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(SSColors.blue.opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }
}

struct SSTextField_Previews: PreviewProvider {
    static var previews: some View {
        SSTextField(title: "First name", text: .constant(""))
    }
}
