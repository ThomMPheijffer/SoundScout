//
//  TeacherHomeScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/05/2023.
//

import SwiftUI

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()
    
    @Published var selection: Panel? = .home
}

enum Panel: Hashable {
    case home
    case schedule
    case students
    case songs
    case profile
}

struct TeacherHomeScreen: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    var body: some View {
        NavigationSplitView {
            TeacherSidebar(selection: $navigationManager.selection)
        } detail: {
            switch navigationManager.selection {
            case .home:
                Text("Home")
            case .schedule:
                Text("Schedule")
            case .students:
                MyStudentsScreen()
            case .songs:
                MySongsScreen()
            case .profile:
                Text("Profile")
            default:
                Text("Default")
            }
        }

    }
}

struct TeacherHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeacherHomeScreen()
    }
}
