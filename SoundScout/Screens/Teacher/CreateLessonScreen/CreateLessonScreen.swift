//
//  CreateLessonScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 09/06/2023.
//

import SwiftUI

struct CreateLessonScreen: View {
    let studentId: String
    @ObservedObject var viewModel = ViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                SSContentBackground {
                    SSTextField(title: "Lesson notes", text: $viewModel.lessonNotes, axis: .vertical)
                    
                    Text("Date")
                        .font(.title3)
                        .padding(.top, 32)
                        .padding(.bottom)
                    DatePicker(selection: $viewModel.lessonDate, in: ...Date.now, displayedComponents: .date) {
                        Text("Select a date")
                    }
                    .labelsHidden()
                    
                    Text("Songs")
                        .font(.title3)
                        .padding(.top, 32)
                        .padding(.bottom)
                    
                    ForEach(viewModel.songs) { song in
                        HStack {
                            if let coverUrl = URL(string: song.coverUrl ?? "") {
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
                                Text(song.title)
                                Text(song.artist)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button(action: { viewModel.songs.removeAll { $0.id == song.id } }) {
                                Image(systemName: "xmark.bin")
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(1))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.2), radius: 2)
                        .padding(.bottom, 8)
                    }
                    
                    Button(action: { viewModel.showPopover = true }) {
                        SSSecondaryNavigationButtonText(text: "Select songs")
                    }
                    
                    Button(action: {
                        Task {
                            let result = await viewModel.createLesson(for: studentId)
                            switch result {
                            case .success(let success):
                                print(success)
                                dismiss()
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }) {
                        SSPrimaryNavigationButtonText(text: "Create lesson", isActive: viewModel.canContinue())
                    }
                    .disabled(!viewModel.canContinue())
                    .padding(.top, 128)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Create lesson")
        .sheet(isPresented: $viewModel.showPopover) {
            SelectSongScreen(allSongs: viewModel.allSongs) { song in
                print(song)
                viewModel.songs.append(song)
            }
        }
        .task {
            guard let teacherId = UserDefaults.standard.string(forKey: "teacherID") else { return }
            let result = await SongsService().getSongsForTeacher(teacherId: teacherId)
            switch result {
            case .success(let songs):
                print(songs)
                self.viewModel.allSongs = songs.songs
            case .failure(let failure):
                print("FAILURE")
                print(failure)
            }
        }
    }
}

struct CreateLessonScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateLessonScreen(studentId: "")
    }
}
