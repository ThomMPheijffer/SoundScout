//
//  SearchSongScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 24/05/2023.
//

import SwiftUI
import SpotifyWebAPI
import Combine

class SearchSongViewModel: ObservableObject {
    let spotify = Spotify()
    
    @Published var searchText = ""
    @Published var isSearching = false
    @Published var tracks: [Track] = []
    
    private var subscriptions = Set<AnyCancellable>()
    private var searchCancellable: AnyCancellable? = nil
    
    init() {
        $searchText
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.search()
            } )
            .store(in: &subscriptions)
    }
    
    func search() {
        
        self.tracks = []
        
        if self.searchText.isEmpty { return }
        
        print("searching with query '\(self.searchText)'")
        self.isSearching = true
        
        self.searchCancellable = spotify.api.search(
            query: self.searchText, categories: [.track]
        )
        //        .debounce(for: 0.5, scheduler: DispatchQueue.main)
        .receive(on: RunLoop.main)
        .sink(
            receiveCompletion: { completion in
                self.isSearching = false
                if case .failure(let error) = completion {
                    print("error")
                    print(error.localizedDescription)
                }
            },
            receiveValue: { searchResults in
//                searchResults.tracks?.items.forEach { print("\($0.name) - \($0.artists?.first?.name)") }
                self.tracks = searchResults.tracks?.items ?? []
                print("received \(self.tracks.count) tracks")
            }
        )
    }
    
}

struct SearchSongScreen: View {
    @EnvironmentObject var spotify: Spotify
    @ObservedObject var viewModel = SearchSongViewModel()
    
    var onSelectSong: ((Track) -> Void)? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.tracks.isEmpty {
                    Text("No results")
                } else {
                    List {
                        ForEach(viewModel.tracks, id: \.self) { track in
                            Button(action: { onSelectSong?(track); dismiss() }) {
                                HStack {
                                    AsyncImage(url: track.album?.images?.first?.url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Color.purple.opacity(0.1)
                                    }
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(4)
                                    
                                    VStack(alignment: .leading) {
                                        Text(track.name)
                                        Text(track.artists?.first?.name ?? "")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    }
                                }
                                .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search song")
            .searchable(text: $viewModel.searchText)
        }
    }
}

struct SearchSongScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchSongScreen()
    }
}
