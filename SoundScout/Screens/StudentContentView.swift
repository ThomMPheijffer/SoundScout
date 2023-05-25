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
    case myMessages
}

struct StudentContentView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    var body: some View {
        NavigationSplitView {
            StudentSidebar(selection: $navigationManager.studentSelection)
        } detail: {
            switch navigationManager.studentSelection {
            case .home:
                StudentHomeScreen()
            case .schedule:
                Text("Schedule")
            case .myTeachers:
                MyTeachersScreen()
            case .findTeachers:
                FindTeachersScreen()
            case .songs:
                MySongsScreen()
            case .profile:
<<<<<<< HEAD:SoundScout/Screens/StudentContentView.swift
                Text("Profile")
            case .myMessages:
                StudentMessagesScreen()
=======
                StudentProfileScreen()
>>>>>>> 09f96e0170a46d9f68d07fdeca105a9278448c7d:SoundScout/Screens/StudentHomeScreen.swift
            default:
                Text("Default")
            }
        }

    }
}

struct StudentHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentContentView()
    }
}

