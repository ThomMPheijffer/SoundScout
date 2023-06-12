//
//  SongDetailScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 22/05/2023.
//

import SwiftUI

struct SongDetailScreen: View {
    let song: Song
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(spacing: 32) {
                if let coverUrl = URL(string: song.coverUrl ?? "") {
                    AsyncImage(url: coverUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.purple.opacity(0.1)
                    }
                    .frame(width: 220, height: 220)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                } else {
                    Color.green
                        .frame(width: 220, height: 220)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(song.title)
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                    Text(song.artist)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {}) {
                            SSSecondaryNavigationButtonText(text: "Play")
                        }
                        NavigationLink(destination: ExercisesOverviewScreen(song: song)) {
                            SSPrimaryNavigationButtonText(text: "Interactive Exercises", fullWidth: false)
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
                Text(song.teacherNotes)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
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
