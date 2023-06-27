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
    
    @ObservedObject var audioPlayer = AudioPlayer()
    @State var showPopover = false
    @State var popoverText = ""
    
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
                    ForEach(Array(practise.feedback!.chord.keys).sorted(by: { first, second in
                        Int(first)! < Int(second)!
                    }), id: \.self) { key in
                        let text = practise.feedback!.chord[key] ?? ""
                        if text.contains("Wrong") {
                            Color.red
                                .frame(height: 30)
                        } else if text.contains("instead") {
                            Button(action: { popoverText = "On seconds: \(Int(Double(key)! / 1000)).\n\(text)"; showPopover = true }) {
                                ZStack {
                                    Color.red
                                        .overlay(
                                            Text(text)
                                                .font(.system(size: 10))
                                                .multilineTextAlignment(.center)
                                                .foregroundStyle(.primary)
                                                .lineLimit(nil)
                                                .padding(.horizontal)
                                        )
                                }
                                .frame(height: 30)
                            }
                        } else {
                            Color.green
                                .frame(height: 30)
                        }
                    }
                }
                .clipShape(Capsule())
                .popover(isPresented: $showPopover) { [popoverText] in
                    Text(popoverText)
                        .font(.headline)
                        .padding()
                        .onAppear {
                            print(popoverText)
                        }
                }
                .padding(.bottom, 32)
                
                Text("Tempo")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(practise.tempoFeedback)
                    .padding(.bottom, 32)
                
                Group {
                    Text("Practise")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        if audioPlayer.isPlaying {
                            audioPlayer.stopPlayback()
                        } else {
                            downloadFile(urlString: practise.sound!)
                        }
                        
                    }) {
                        Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                            .foregroundStyle(.black)
                            .padding()
                            .background(Circle().fill(Color.gray.opacity(0.2)))
                    }
                    .padding(.bottom, 32)
                    
                }
                
//                Group {
//                    Text("DEBUG")
//                    Text("\(practise.similarityGrade)")
//                    Text("\(practise.tempoGrade)")
//                    Text("\(practise.chordsGrade)")
//                    Text("\(practise.grade)")
//                }
                
            }
            .padding()
        }
        .navigationTitle(Text(practise.date, style: .date))
    }
    
    func downloadFile(urlString: String) {
        if let audioUrl = URL(string: urlString) {
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            print(destinationUrl)
            
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("File already exists on disk")
                audioPlayer.startPlayback(audio: destinationUrl)
            } else {
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File created on disk")
                        audioPlayer.startPlayback(audio: destinationUrl)
                    } catch let error as NSError {
                        print(error)
                    }
                }).resume()
            }
        }
        
    }
    
}
