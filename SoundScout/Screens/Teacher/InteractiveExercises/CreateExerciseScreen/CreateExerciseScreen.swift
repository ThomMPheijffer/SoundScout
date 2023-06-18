//
//  CreateExerciseScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import SwiftUI

struct CreateExerciseScreen: View {
    let songId: String
    @ObservedObject var viewModel = ViewModel()
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var audioPlayer = AudioPlayer()
    
    @Environment(\.dismiss) var dismiss
    
    @State var presentReviewExercise = false
    
    var body: some View {
        HStack {
            
            Color.blue
                .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: 0) {
                SSTextField(title: "Exercise name", text: $viewModel.name)
                    .padding(.bottom, 32)
                
                SSTextField(title: "Tempo", text: $viewModel.tempo)
                    .padding(.bottom, 64)
                
                Spacer()
                
                VStack {
                    Text(audioRecorder.timer)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button(action: { audioRecorder.isRecording ? audioRecorder.stopRecording() : audioRecorder.startRecording() }) {
                        SSSecondaryNavigationButtonText(text: audioRecorder.isRecording ? "􀛷 Stop" :  "􀊃 Play")
                    }
                }
                
                Spacer()
                
                Button(action: {
                    presentReviewExercise = true
                }) {
                    SSPrimaryNavigationButtonText(text: "Create exercise", isActive: viewModel.canContinue())
                }
                .disabled(!viewModel.canContinue() || audioRecorder.recordingURL == nil)
            }
            .frame(maxWidth: 300)
            .padding()
        }
        .navigationTitle("Create exercise")
        .sheet(isPresented: $presentReviewExercise) {
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("Review audio")
                        .font(.title3)
                        .bold()
                        .padding(.bottom, 8)
                    
                    
                    Group {
                        if audioPlayer.isPlaying == false {
                            Button(action: {
                                self.audioPlayer.startPlayback(audio: audioRecorder.recordingURL!)
                            }) {
                                Image(systemName: "play.circle")
                                    .imageScale(.large)
                            }
                        } else {
                            Button(action: {
                                self.audioPlayer.stopPlayback()
                            }) {
                                Image(systemName: "stop.fill")
                                    .imageScale(.large)
                            }
                        }
                    }.padding(.bottom, 64)
                    
                    
                    Button(action: {
                        Task {
                            let result = await viewModel.postExercise(songId: songId)
                            switch result {
                            case .success(let success):
                                print(success)
                                dismiss()
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }) {
                        SSPrimaryNavigationButtonText(text: "Create exercise", isActive: viewModel.canContinue())
                    }
                }
                .padding()
                .navigationTitle("Review exercise")
            }
        }
    }
}

func covertSecToMinAndHour(seconds : Int) -> String{
    
    let (_,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    let sec : String = s < 10 ? "0\(s)" : "\(s)"
    return "\(m):\(sec)"
    
}

