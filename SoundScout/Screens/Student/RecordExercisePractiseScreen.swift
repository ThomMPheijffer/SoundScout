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
    
    @State var bpm = 80
    @State var countDown = 4
    @State var count = -1
    @State var recordingState: RecordingState = .identity
    
    @State var selectedDocumentWrapper: DocumentWrapper = DocumentWrapper(data: Data(), documentName: "")
    @State var documentData = [DocumentWrapper]()
    
    @State private var selectedIndex = 3
    
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
                Text("Select BPM")
                    .font(.title3)
                    .padding(.bottom, 8)
                VStack {
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 0, text: "\(Int(Double(exercise.tempo) * 0.7)) bpm (0.7x)")
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 1, text: "\(Int(Double(exercise.tempo) * 0.8)) bpm (0.8x)")
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 2, text: "\(Int(Double(exercise.tempo) * 0.9)) bpm (0.9x)")
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 3, text: "\(Int(Double(exercise.tempo) * 1.0)) bpm (1.0x)")
                }
                .onChange(of: selectedIndex) { _ in
                    bpm = getBpmForIndex()
                }
                
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
        .onAppear {
            bpm = song.bpm
        }
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
                            print("-------")
                            print(UserDefaults.standard.string(forKey: "studentID"))
                            guard let studentId = UserDefaults.standard.string(forKey: "studentID") else { return  }
                            let recordingData = try! Data(contentsOf: audioRecorder.recordingURL!)
                            
                            var multipart = MultipartRequest()
                            multipart.add(key: "payload", value: PostExercisePractise(exerciseId: exercise.id, studentId: studentId, tempo: getBpmForIndex()).stringified())
                            multipart.add(key: "cover-song", fileName: "\(UUID().uuidString).mp4", fileMimeType: "audio/mp4", fileData: recordingData)
                            
                            let result = await ExercisePractisesService().postExercisePractise(practiseMultipartRequest: multipart)
                            switch result {
                            case .success(let success):
                                print(success)
                                
                                audioRecorder.newRecording()
                                recordingState = .identity
                                count = -1
                                countDown = 4
                                presentReviewExercise = false
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
    
    func getBpmForIndex() -> Int {
        switch selectedIndex {
        case 0:
            return Int(Double(exercise.tempo) * 0.7)
        case 1:
            return Int(Double(exercise.tempo) * 0.8)
        case 2:
            return Int(Double(exercise.tempo) * 0.9)
        case 3:
            return Int(Double(exercise.tempo) * 1.0)
        default:
            return Int(Double(exercise.tempo) * 1.0)
        }
    }
    
}
