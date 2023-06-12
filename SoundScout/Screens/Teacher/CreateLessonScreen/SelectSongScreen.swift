//
//  SelectSongScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import SwiftUI

struct SelectSongScreen: View {
    var allSongs: [Song]
    var onAdd: ((Song) -> Void)
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(allSongs, id: \.title) { song in
                    Button(action: {
                        onAdd(song)
                        dismiss()
                    }) {
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
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(song.title)
                                    .font(.callout)
                                
                                Text(song.artist)
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.leading)
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Select song")
        }
    }
}
