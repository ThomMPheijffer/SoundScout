//
//  SoundScoutApp.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI
import SpotifyWebAPI

@main
struct SoundScoutApp: App {
    @StateObject var navigationManager = NavigationManager.shared
    @StateObject var spotify = Spotify()
    
    init() {
        SpotifyAPILogHandler.bootstrap()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            TeacherHomeScreen()
//                .environmentObject(navigationManager)
                .environmentObject(spotify)
        }
    }
}
