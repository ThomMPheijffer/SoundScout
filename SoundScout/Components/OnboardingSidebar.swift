//
//  OnboardingSidebar.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct OnboardingSidebar: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("SoundScout")
                .font(.largeTitle)
                .padding(.bottom, 64)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Start your jourey with us.")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
                .frame(maxWidth: 180)
            
            Text("Discover the best way to teach and learn an instrument")
                .bold()
                .frame(maxWidth: 250)
            
            Spacer()
        }
        .padding(32)
        .foregroundColor(Color.white)
        .frame(maxWidth: UIScreen.main.bounds.width / 3)
        .background(SSColors.blue)
        .cornerRadius(16)
    }
}

struct OnboardingSidebar_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSidebar()
    }
}
