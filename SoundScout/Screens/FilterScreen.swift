//
//  FilterScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 24.5.23..
//

import SwiftUI

struct FilterScreen: View {
    @State private var selectedIndex = 0
    @State private var sliderValue: Double = 50.0
    
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
                
                Text("Which lessons are you looking for?")
                    .font(.title3)
                    .padding(.bottom, 16)
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
                
                Text("Where do you want to have your class?")
                    .font(.title3)
                    .padding(.bottom, 16)
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
                
                Text("Price range(per lesson, in euros)")
                    .font(.title3)
                    .padding(.bottom, 16)
                  HStack {
                    Text("10").bold()
                    Slider(value: $sliderValue, in: 10.0...200.0)
                    Text("200").bold()
                  }

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
