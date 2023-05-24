//
//  FilterScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 24.5.23..
//

import SwiftUI

struct FilterScreen: View {
    @State private var selectedIndex = 0
    
    var body: some View {
            SSContentBackground {
                HStack {
                    Text("Filter")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink(destination: Text("Reset")) {
                        SSSecondaryNavigationButtonText(text: "Reset")
                    }
                }.padding(.bottom, 64)
                
                HStack {
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 0, text: "Instrument")
                    Spacer()
                        .frame(width: 16)
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 1, text: "Theory")
                    Spacer()
                        .frame(width: 16)
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 2, text: "Vocal")
                }
                .padding(.top, 8)
                .padding(.bottom, 32)
                
                HStack {
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 3, text: "Online")
                    Spacer()
                        .frame(width: 16)
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 4, text: "In-person")
                    Spacer()
                        .frame(width: 16)
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 5, text: "Both")
                }
                .padding(.top, 8)
                .padding(.bottom, 32)
                
                Spacer()
                
                NavigationLink(destination: Text("Continue")) {
                    SSPrimaryNavigationButtonText(text: "Continue")
                    // Here instead of continue should be "Show i results", with i being dynamic
                }
            }
            .padding(.horizontal)
            
    }
}

struct FilterScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilterScreen()
    }
}
