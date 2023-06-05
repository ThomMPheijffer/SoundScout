//
//  SongDetailScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 22/05/2023.
//

import SwiftUI

struct SongDetailScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(spacing: 32) {
                Color.green
                    .frame(width: 220, height: 220)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Thinking out loud")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                    Text("Ed Sheeran")
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {}) {
                            SSSecondaryNavigationButtonText(text: "Play")
                        }
                        Button(action: {}) {
                            SSSecondaryNavigationButtonText(text: "Interactive Exercises")
                        }
                        
                        Spacer()
                    }
                }
                
            }
            .padding(.bottom, 64)
            
            SSContentBackground(padding: 16) {
                Text("Teacher notes")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies felis eu enim consequat, nec luctus enim posuere. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque hendrerit nunc nunc, at cursus tortor interdum at. Ut eget vehicula lacus. Nam non fermentum nulla.")
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 32)
            
            SSContentBackground(padding: 16) {
                Text("Additional resources")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies felis eu enim consequat, nec luctus enim posuere. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque hendrerit nunc nunc, at cursus tortor interdum at. Ut eget vehicula lacus. Nam non fermentum nulla.")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .navigationTitle("Thinking out loud")
    }
}

struct SongDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailScreen()
    }
}
