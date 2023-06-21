//
//  RecordExercisePractiseScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/06/2023.
//

import SwiftUI

struct RecordExercisePractiseScreen: View {
    let song: Song
    let exercise: Exercise
    
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var audioPlayer = AudioPlayer()
    
    @Environment(\.dismiss) var dismiss
    
    @State var presentReviewExercise = false
    
    var body: some View {
        HStack {
            
            if song.documentUrls.count != 0 {
                PDFKitRepresentedViewAsync(URL(string: song.documentUrls.first!)!)
                    .padding()
            } else {
                Color.blue.padding()
            }
                
            
            Divider()
            
            VStack(alignment: .leading, spacing: 0) {
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
                    SSPrimaryNavigationButtonText(text: "Create exercise", isActive: audioRecorder.recordingURL != nil)
                }
                .disabled(audioRecorder.recordingURL == nil)
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
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        Task {
                            guard let studentId = UserDefaults.standard.string(forKey: "studentID") else { return  }
                            let recordingData = try! Data(contentsOf: audioRecorder.recordingURL!)
                            
                            var multipart = MultipartRequest()
                            multipart.add(key: "payload", value: PostExercisePractise(exerciseId: exercise.id, studentId: studentId, tempo: exercise.tempo).stringified())
                            multipart.add(key: "cover-song", fileName: "\(UUID().uuidString).mp4", fileMimeType: "audio/mp4", fileData: recordingData)
                            
                            let result = await ExercisePractisesService().postExercisePractise(practiseMultipartRequest: multipart)
                            switch result {
                            case .success(let success):
                                print(success)
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }) {
                        SSPrimaryNavigationButtonText(text: "Submit practise")
                    }
                    
                }
                .padding()
                .navigationTitle("Practise")
            }
        }
    }
}
