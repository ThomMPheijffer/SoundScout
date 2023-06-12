//
//  LessonDetailScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct StudentLessonDetailsScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    let lesson: Lesson
    
    let addResources = [
        "Music stave",
        "Chords overview",
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                SSContentBackground(padding: 32) {
                    Text( "Lesson notes")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                    Text(lesson.lessonNotes)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
             
                if let unwrappedSongs = lesson.songs, unwrappedSongs.count > 0 {
                    SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
                        Text("Songs")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 8)
                            .padding(.top, 32)
                        
                        Divider()
                            .padding(.horizontal, -32)
                        
                        ForEach(0..<unwrappedSongs.count, id: \.self) { i in
                            HStack {
                                if let coverUrl = URL(string: unwrappedSongs[i].coverUrl ?? "") {
                                    AsyncImage(url: coverUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Color.purple.opacity(0.1)
                                    }
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(4)
                                    .shadow(radius: 2)
                                } else {
                                    Color.green
                                        .frame(width: 40, height: 40)
                                }
                                VStack(alignment: .leading) {
                                    Text(unwrappedSongs[i].title)
                                    Text(unwrappedSongs[i].artist)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                NavigationLink(destination: StudentSongDetailsScreen(song: unwrappedSongs[i])) {
                                    HStack {
                                        Text("Show material")
                                        Image(systemName: "chevron.right")
                                    }
                                    .font(.callout)
                                    .bold()
                                }
                            }
                            .font(.callout)
                            .padding(.vertical)

                            if i != (unwrappedSongs.count - 1) {
                                Divider()
                                    .padding(.horizontal, -32)
                            }
                        }
                    }
                }
                
                SSContentBackground(padding: 32) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Additional resources")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 8)
                            ForEach(0..<addResources.count, id: \.self) { i in
                                HStack {
                                    Image(systemName: "doc")
                                    Text(addResources[i])
                                }
                                .font(.callout)
                            }
                        }
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Lesson - January")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: StudentMessagesScreen()) {
                    Image(systemName: "bell.badge").font(.title2).foregroundColor(Color.black)
                }
            }
        }
    }
}



