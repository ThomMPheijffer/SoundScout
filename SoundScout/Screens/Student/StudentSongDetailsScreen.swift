//
//  StudentSongDetailsScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 27.5.23..
//
import SwiftUI

struct StudentSongDetailsScreen: View {
    let song: Song
    
    let additionalResources = [
        "Thinking out loud - easy",
        "Thinking out loud - hard",
        "Thinking out loud - guitar only",
        "Thinking out loud - youtube",
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
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
                    
                    VStack(alignment: .leading) {
                        Text(song.title)
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 8)
                        Text(song.artist)
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            Button(action: {}) {
                                SSSecondaryNavigationButtonText(text: "Play")
                            }
                            
                            NavigationLink(destination: ExercisesOverviewScreen(song: song)) {
                                SSPrimaryNavigationButtonText(text: "Exercises", fullWidth: false)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                }
                .padding(.bottom, 32)
                
                SSContentBackground(padding: 32) {
                    Text( "Teacher notes")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                    Text(song.teacherNotes)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 32)
                
                SSContentBackground(padding: 16) {
                    Text("Additional resources")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if song.documentUrls.count != 0 {
                        ForEach(song.documentUrls, id: \.self) { url in
                            NavigationLink(destination: PDFKitRepresentedViewAsync(URL(string: url)!)) {
                                HStack {
                                    Image(systemName: "doc")
                                    Text((URL(string: url)!.lastPathComponent as NSString).deletingPathExtension)
                                        .underline()
                                }
                                .foregroundColor(.secondary)
                            }
                        }
                    } else {
                        Text("No additional resources provided for this song.")
                            .foregroundColor(.secondary)
                    }
                }
                
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
