//
//  TeacherContentView.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()

    @Published var teacherSelection: TeacherPanel? = .students
    @Published var studentSelection: StudentPanel? = .findTeachers
}

enum TeacherPanel: Hashable {
//    case home
//    case schedule
    case students
    case songs
    case profile
//    case myMessages
}

struct TeacherContentView: View {

    @EnvironmentObject private var navigationManager: NavigationManager

    var body: some View {
        NavigationSplitView {
            TeacherSidebar(selection: $navigationManager.teacherSelection)
        } detail: {
            NavigationStack {
                switch navigationManager.teacherSelection {
                    //            case .home:
                    //                TeacherHomeScreen()
                    //            case .schedule:
                    //                Text("Schedule")
                case .students:
                    MyStudentsScreen()
                case .songs:
                    MySongsScreen()
                case .profile:
                    TeacherProfileScreen()
                    //            case .myMessages:
                    //                TeacherMessagesScreen()
                default:
                    Text("Default")
                }
            }
        }
    }
}

struct TeacherHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeacherContentView()
    }
}
