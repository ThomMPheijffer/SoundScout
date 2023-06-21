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
    
    @State var bpm: Double = 80.0
    @State var countDown = 4
    @State var count = -1
    @State var recordingState: RecordingState = .identity
    
    @State var selectedUrl: String = ""
    
    var body: some View {
        HStack {
            if song.documentUrls.count != 0 {
                VStack {
                    Picker("Selected file", selection: $selectedUrl) {
                        ForEach(song.documentUrls, id: \.self) {
                            Text("\((URL(string: $0)!.lastPathComponent as NSString).deletingPathExtension)")
                        }
                    }
                    .pickerStyle(.menu)
                    .onAppear {
                        selectedUrl = song.documentUrls.first!
                    }
                    .onChange(of: selectedUrl) { newValue in
                        print(newValue)
                    }
                    
                    if selectedUrl != "" {
                        PDFKitRepresentedViewAsync(URL(string: selectedUrl)!)
                            .padding()
                    }
                }
            } else {
                Color.blue.padding()
            }
                
            
            Divider()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("BPM: \(bpm)")
                
                Spacer()
                
                RecordingView(recordingState: $recordingState, count: $count, countDown: $countDown, bpm: $bpm).environmentObject(audioRecorder)
                
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
                        audioRecorder.newRecording()
                        recordingState = .identity
                        count = -1
                        countDown = 4
                        presentReviewExercise = false
                    }) {
                        SSSecondaryNavigationButtonText(text: "Practise again", fullWidth: true)
                    }
                    
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
