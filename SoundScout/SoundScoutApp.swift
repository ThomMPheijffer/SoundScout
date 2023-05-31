//
//  SoundScoutApp.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI
import SpotifyWebAPI
import Combine

@main
struct SoundScoutApp: App {
    @StateObject var navigationManager = NavigationManager.shared
    @StateObject var spotify = Spotify()
    
    @State private var cancellables: Set<AnyCancellable> = []
    
    init() {
        SpotifyAPILogHandler.bootstrap()
    }
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
              SignUpScreen()
                .environmentObject(navigationManager)
                .environmentObject(spotify)
                .onOpenURL(perform: handleURL(_:))
                .task {
                    
                    
                    let result = await InstrumentsService().getAllInstruments()
                    switch result {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure)
                    }
                    
                    let create = await InstrumentsService().postInstrument(instrument: .init(name: "Drums"))
                    switch create {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure)
                    }
                }
        }
    }
    
    func handleURL(_ url: URL) {
        guard url.scheme == self.spotify.loginCallbackURL.scheme else { print("not handling URL: unexpected scheme: '\(url)'"); return }
        
        print("received redirect from Spotify: '\(url)'")
        
        spotify.isRetrievingTokens = true
        spotify.api.authorizationManager.requestAccessAndRefreshTokens(redirectURIWithQuery: url, state: spotify.authorizationState)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                self.spotify.isRetrievingTokens = false
                if case .failure(let error) = completion {
                    print("couldn't retrieve access and refresh tokens:\n\(error)")
                }
            })
            .store(in: &cancellables)
        
        self.spotify.authorizationState = String.randomURLSafe(length: 128)
        
    }
    
}
