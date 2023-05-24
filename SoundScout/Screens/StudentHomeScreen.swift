//
//  StudentHomeScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 24.5.23..
//

//
//  TeacherHomeScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/05/2023.
//

import SwiftUI


enum StudentPanel: Hashable {
    case home
    case schedule
    case myTeachers
    case findTeachers
    case songs
    case profile
}

struct StudentHomeScreen: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    var body: some View {
        NavigationSplitView {
            StudentSidebar(selection: $navigationManager.studentSelection)
        } detail: {
            switch navigationManager.studentSelection {
            case .home:
                Text("Home")
            case .schedule:
                Text("Schedule")
            case .myTeachers:
                Text("My teachers")
            case .findTeachers:
                FindTeachersScreen()
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

struct StudentHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentHomeScreen()
    }
}

