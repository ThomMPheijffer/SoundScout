//
//  MySongsScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/05/2023.
//

import SwiftUI

struct MySongsScreen: View {
    @State private var searchText = ""
    @State private var songs : [Song] = []
    @EnvironmentObject var spotify: Spotify
    
    var body: some View {
        List {
            ForEach(songs, id: \.title) { song in
                NavigationLink(destination: SongDetailScreen(song: song)) {
                    HStack(spacing: 0) {
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
                        
                        Text(song.title)
                            .font(.callout)
                            .padding(.leading, 16)
                            .frame(width: 200, alignment: .leading)
                        
                        Text(song.artist)
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .padding(.leading, 64)
                    }
                }
            }
        }
        .navigationTitle("My Songs")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    spotify.isAuthorized ? spotify.api.authorizationManager.deauthorize() : spotify.authorize()
                }) {
                    SSPrimaryNavigationButtonText(text: spotify.isAuthorized ? "Logout" : "Authorize Spotify")
                }
                
                
                NavigationLink(destination: AddSongScreen()) {
                    SSPrimaryNavigationButtonText(text: "Add song")
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search songs")
        .task {
            guard let teacherId = UserDefaults.standard.string(forKey: "teacherID") else { return }
            let result = await SongsService().getSongsForTeacher(teacherId: teacherId)
            switch result {
            case .success(let songs):
                print(songs)
                self.songs = songs.songs
            case .failure(let failure):
                print("FAILURE")
                print(failure)
            }
        }
    }
}

struct MySongsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MySongsScreen()
    }
}
