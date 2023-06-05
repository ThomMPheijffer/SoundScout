//
//  MySongsScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/05/2023.
//

import SwiftUI

struct MySongsScreen: View {
    @State private var searchText = ""
    @EnvironmentObject var spotify: Spotify
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10, id: \.self) { i in
                    NavigationLink(destination: SongDetailScreen()) {
                        HStack(spacing: 0) {
                            Color.green
                                .frame(width: 40, height: 40)
                            
                            Text("Thinking out loud")
                                .font(.callout)
                                .padding(.leading, 16)
                            
                            Text("Ed Sheeran")
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
                let result = await SongsService().getAllSongs()
                switch result {
                case .success(let songs):
                    print(songs)
                    //self.songs = .instruments
                case .failure(let failure):
                    print("FAILURE")
                    print(failure)
                }
            }
        }
        
    }
}

struct MySongsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MySongsScreen()
    }
}
