//
//  PractiseDetailScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 25/06/2023.
//

import SwiftUI
import AVFoundation

struct PractiseDetailScreen: View {
    let exercise: Exercise
    let practise: ExercisePractise
    
    @State var player: AVPlayer? = nil
    @State var currentPlayerIndex = 2
    
    var body: some View {
        ScrollView {
            SSContentBackground(padding: 16) {
                Text("Grade")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(practise.grade)")
                    .padding(.bottom, 32)
                
                Text("Practise detail")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 0) {
                    ForEach(Array(practise.feedback!.chord.keys), id: \.self) { key in
                        let text = practise.feedback!.chord[key] ?? ""
                        if text.contains("Wrong") {
                            Color.red
                                .frame(height: 20)
                        } else if text.contains("instead") {
                            Color.yellow
                                .frame(height: 20)
                        } else {
                            Color.green
                                .frame(height: 20)
                        }
                    }
                }
                .clipShape(Capsule())
                .padding(.bottom, 32)
                
                Text("Tempo")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(practise.tempoFeedback)
                    .padding(.bottom, 32)
                
                Text("Practise")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    if player?.timeControlStatus == .playing && currentPlayerIndex == 0 {
                        player?.pause()
                    } else if player?.timeControlStatus == .paused && currentPlayerIndex == 0 {
                        player?.play()
                    } else {
                        let url = URL(string: practise.sound ?? "")!
                        let playerItem = AVPlayerItem(url: url)
                        self.player = AVPlayer(playerItem: playerItem)
                        player!.volume = 1.0
                        player!.play()
                    }
                    currentPlayerIndex = 0
                }) {
                    Image(systemName: player?.timeControlStatus == .playing ? "pause.fill" : "play.fill")
                        .foregroundStyle(.black)
                        .padding()
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
                .padding(.bottom, 32)
                
                Text("Orignal")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    if player?.timeControlStatus == .playing && currentPlayerIndex == 1 {
                        player?.pause()
                    } else if player?.timeControlStatus == .paused && currentPlayerIndex == 1 {
                        player?.play()
                    } else {
                        let url = URL(string: exercise.soundUrl ?? "")!
                        let playerItem = AVPlayerItem(url: url)
                        self.player = AVPlayer(playerItem: playerItem)
                        player!.volume = 1.0
                        player!.play()
                    }
                    currentPlayerIndex = 1
                }) {
                    Image(systemName: player?.timeControlStatus == .playing ? "pause.fill" : "play.fill")
                        .foregroundStyle(.black)
                        .padding()
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
                .padding(.bottom, 32)
                
            }
            .padding()
        }
        .navigationTitle(Text(practise.date, style: .date))
    }
}
