//
//  CreateExerciseScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import SwiftUI

struct CreateExerciseScreen: View {
    let song: Song
    @ObservedObject var viewModel = ViewModel()
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var audioPlayer = AudioPlayer()
    
    @Environment(\.dismiss) var dismiss
    
    @State var presentReviewExercise = false
    
//    @State var bpm = song.bpm
    @State var countDown = 4
    @State var count = -1
    @State var recordingState: RecordingState = .identity
    
    @State var selectedDocumentWrapper: DocumentWrapper = DocumentWrapper(data: Data(), documentName: "")
    @State var documentData = [DocumentWrapper]()
    
    var body: some View {
        HStack {
            if documentData.count != 0 {
                VStack {
                    if documentData.count > 1 {
                        Picker("Selected file", selection: $selectedDocumentWrapper) {
                            ForEach(documentData, id: \.self) {
                                Text($0.documentName)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    if selectedDocumentWrapper.documentName != "" {
                        PDFKitRepresentedView(selectedDocumentWrapper.data)
                            .padding()
                    }
                }
                .onAppear {
                    selectedDocumentWrapper = documentData.first!
                }
            } else {
                Color.blue.padding()
            }
                
            
            Divider()
            
            VStack(alignment: .leading, spacing: 0) {
                SSTextField(title: "Exercise name", text: $viewModel.name)
                    .padding(.bottom, 32)
                
                Spacer()
                
                RecordingView(recordingState: $recordingState, count: $count, countDown: $countDown, bpm: .constant(song.bpm)).environmentObject(audioRecorder)
                
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
        .task {
            guard documentData.count == 0 else { return }
            for url in song.documentUrls {
                guard let (data, _) = try? await URLSession.shared.data(from: URL(string: url)!) else { return }
                self.documentData.append(.init(data: data, documentName: (URL(string: url)!.lastPathComponent)))
            }
        }
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
                            let result = await viewModel.postExercise(songId: song.id, tempo: song.bpm)
                            switch result {
                            case .success(let exercise):
                                print(exercise)
                                
                                let recordingData = try! Data(contentsOf: audioRecorder.recordingURL!)
                                var multipart = MultipartRequest()
                                multipart.add(
                                    key: "song",
                                    fileName: "\(UUID().uuidString).mp4",
                                    fileMimeType: "audio/mp4",
                                    fileData: recordingData
                                )
                                
                                print(multipart)
                                print(audioRecorder.recordingURL!)
                                
                                let addingSoundResult = await ExercisesService().postSong(exerciseId: exercise.id, songMultipartRequest: multipart)
                                switch addingSoundResult {
                                case .success(let success):
                                    print(success)
                                    dismiss()
                                case .failure(let failure):
                                    print(failure)
                                }
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

