//
//  AddSongScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 22/05/2023.
//

import SwiftUI

struct AddSongScreen: View {
    @State var showPopover = false
    
    @State var songName: String = ""
    @State var artist: String = ""
    @State var coverUrl: URL? = nil
    @State var teacherNotes: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SSTextField(title: "Song name", text: $songName)
                .padding(.bottom, 32)
            
            SSTextField(title: "Artist", text: $artist)
                .padding(.bottom, 32)
            
            Text("Cover art")
                .font(.title3)
                .padding(.bottom)
            if coverUrl != nil {
                AsyncImage(url: coverUrl) { image in
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
            
            SSTextField(title: "Teacher notes", text: $teacherNotes, axis: .horizontal)
                .padding(.bottom, 32)
            
            Text("Interactive exercise")
                .padding(.bottom)
            NavigationLink(destination: Text("Create interactive exercise")) {
                SSSecondaryNavigationButtonText(text: "Create interactive exercise")
            }
            .padding(.bottom, 64)
            
            NavigationLink(destination: TeacherSongDetailsScreen()) {
                SSPrimaryNavigationButtonText(text: "Create song")
            }
            .padding(.bottom, 128)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Add song")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showPopover = true }) {
                    SSPrimaryNavigationButtonText(text: "Add song via Spotify")
                }
            }
        }
        .sheet(isPresented: $showPopover) {
            SearchSongScreen { track in
                self.songName = track.name
                self.artist = track.artists?.first?.name ?? self.artist
                self.coverUrl = track.album?.images?.first?.url
            }
        }
    }
}

struct AddSongScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddSongScreen()
    }
}
