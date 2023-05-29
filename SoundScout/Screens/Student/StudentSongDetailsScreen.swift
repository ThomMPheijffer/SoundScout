//
//  StudentSongDetailsScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 27.5.23..
//
import SwiftUI

struct StudentSongDetailsScreen: View {    
    let additionalResources = [
        "Thinking out loud - easy",
        "Thinking out loud - hard",
        "Thinking out loud - guitar only",
        "Thinking out loud - youtube",
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Color.green
                    .frame(width: 220, height: 220)
                
                VStack(alignment: .leading) {
                    Text("Thinking out loud")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                    Text("Ed Sheeran")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 125)
                    
                    HStack {
                        Button(action: {}) {
                            SSSecondaryNavigationButtonText(text: "Play")
                        }.padding(16)
                        
                        NavigationLink(destination: StudentExercisesScreen()) {
                            SSPrimaryNavigationButtonText(text: "Exercises", fullWidth: false)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            
            SSContentBackground(padding: 32) {
                Text( "Teacher notes")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 8)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies felis eu enim consequat, nec luctus enim posuere. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque hendrerit nunc nunc, at cursus tortor interdum at. Ut eget vehicula lacus. Nam non fermentum nulla.")
            }

            SSContentBackground(padding: 32) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Additional resources")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 8)
                        ForEach(0..<additionalResources.count, id: \.self) { i in
                            HStack {
                                Image(systemName: "doc")
                                Text(additionalResources[i])
                            }
                            .font(.callout)
                        }
                    }
                    Spacer()
                }
            }

        }.padding()
    }
}
