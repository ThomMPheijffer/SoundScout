//
//  SoundScoutApp.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

@main
struct SoundScoutApp: App {
    @StateObject var navigationManager = NavigationManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            TeacherHomeScreen()
//                .environmentObject(navigationManager)
        }
    }
}
