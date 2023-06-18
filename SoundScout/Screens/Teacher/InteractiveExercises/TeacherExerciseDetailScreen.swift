//
//  TeacherExerciseDetailScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/06/2023.
//

import SwiftUI
import AVKit

struct TeacherExerciseDetailScreen: View {
    @State var player = AVPlayer()
    @State var isPlaying: Bool = false
    
    let song: Song
    let exercise: Exercise
    
    var body: some View {
        ScrollView {
            VStack {
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
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 64)
                
                Divider()
                    .padding(.trailing, -16)
                    .padding(.bottom, 64)
                
//                SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
//                    Text("Recording")
//                        .font(.title2)
//                        .bold()
//                        .padding(.top, 32)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    VideoPlayer(player: player)
//                        .frame(width: 320, height: 180, alignment: .center)
//                        .onAppear {
//                            player = AVPlayer(url: URL(string: exercise.soundUrl)!)
//                        }
//                        .padding(.bottom)
//                    
//                    Button {
//                        isPlaying ? player.pause() : player.play()
//                        isPlaying.toggle()
//                        player.seek(to: .zero)
//                    } label: {
//                        Image(systemName: isPlaying ? "stop" : "play")
//                            .padding()
//                    }
//                }
                
                SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
                    Text("History")
                        .font(.title2)
                        .bold()
                        .padding(.top, 32)
                    
                    Divider()
                        .padding(.horizontal, -32)
                        .padding(.bottom)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .navigationTitle(exercise.title)
        .navigationBarTitleDisplayMode(.large)
    }
}
