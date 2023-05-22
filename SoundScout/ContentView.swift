//
//  ContentView.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigationManager = NavigationManager()
    
    var body: some View {
        TeacherHomeScreen()
            .environmentObject(navigationManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
