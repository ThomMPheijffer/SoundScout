//
//  SSContentBackground.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct SSContentBackground<Content: View>: View {
    
    let padding: CGFloat
    let content: Content
    
    init(padding: CGFloat = 64, @ViewBuilder _ content: () -> Content) {
        self.padding = padding
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .padding(padding)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.03))
        .cornerRadius(16)
    }
        
}

struct SSContentBackground_Previews: PreviewProvider {
    static var previews: some View {
        SSContentBackground {
            Text("abc")
        }
    }
}
