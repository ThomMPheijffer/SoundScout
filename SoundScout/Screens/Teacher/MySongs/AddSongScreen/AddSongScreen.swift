//
//  AddSongScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 22/05/2023.
//

import SwiftUI

struct AddSongScreen: View {
    @ObservedObject var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SSTextField(title: "Song name", text: $viewModel.songName)
                .padding(.bottom, 32)
            
            SSTextField(title: "Artist", text: $viewModel.artist)
                .padding(.bottom, 32)
            
            Text("Cover art")
                .font(.title3)
                .padding(.bottom)
            if viewModel.coverUrl != nil {
                AsyncImage(url: viewModel.coverUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.purple.opacity(0.1)
                }
                .frame(width: 120, height: 120)
                .cornerRadius(8)
                .padding(.bottom, 32)
            } else {
                Button(action: {}) {
                    SSSecondaryNavigationButtonText(text: "Upload cover art")
                }
                .padding(.bottom, 32)
            }
            
            SSTextField(title: "Teacher notes", text: $viewModel.teacherNotes, axis: .horizontal)
//                .padding(.bottom, 32)
//
//            Text("Interactive exercise")
//                .padding(.bottom)
//            NavigationLink(destination: Text("Create interactive exercise")) {
//                SSSecondaryNavigationButtonText(text: "Create interactive exercise")
//            }
            .padding(.bottom, 64)
            
            Button(action: {
                Task {
                    let result = await viewModel.postSong()
                    switch result {
                    case .success(let success):
                        print(success)
                        dismiss()
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }) {
                SSPrimaryNavigationButtonText(text: "Create song", isActive: viewModel.canContinue())
            }
            .disabled(!viewModel.canContinue())
            .padding(.bottom, 128)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Add song")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.showPopover = true }) {
                    SSPrimaryNavigationButtonText(text: "Add song via Spotify")
                }
            }
        }
        .sheet(isPresented: $viewModel.showPopover) {
            SearchSongScreen { track in
                self.viewModel.songName = track.name
                self.viewModel.artist = track.artists?.first?.name ?? self.viewModel.artist
                self.viewModel.coverUrl = track.album?.images?.first?.url
            }
        }
    }
}

struct AddSongScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddSongScreen()
    }
}
