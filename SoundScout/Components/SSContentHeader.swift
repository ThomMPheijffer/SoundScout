//
//  SSContentHeader.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct SSContentHeader: View {
    let text: String
    let buttonText : String
    let onButtonTapped: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(text)
                .font(.title2)
                .bold()

            Spacer()

            Button(action: { onButtonTapped?() }) {
                HStack {
                    Text(buttonText)
                    Image(systemName: "chevron.right")
                }
                .font(.callout)
                .bold()
            }

        }
    }
}

struct SSContentHeader_Previews: PreviewProvider {
    static var previews: some View {
        SSContentHeader(text: "Schedule", buttonText: "Show complete schedule")
    }
}
