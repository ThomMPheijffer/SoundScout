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
            if UserDefaults.standard.string(forKey: "teacherUserID") != nil {
                TeacherContentView()
                  .environmentObject(navigationManager)
                  .environmentObject(spotify)
                  .onOpenURL(perform: handleURL(_:))
            } else if UserDefaults.standard.string(forKey: "studentUserID") != nil {
                StudentContentView()
                  .environmentObject(navigationManager)
                  .environmentObject(spotify)
                  .onOpenURL(perform: handleURL(_:))
            } else {
                SignUpScreen()
                  .environmentObject(navigationManager)
                  .environmentObject(spotify)
                  .onOpenURL(perform: handleURL(_:))
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
