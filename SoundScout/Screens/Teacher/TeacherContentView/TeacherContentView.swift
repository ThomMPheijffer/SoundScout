//
//  TeacherContentView.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()

    @Published var teacherSelection: TeacherPanel? = .home
    @Published var studentSelection: StudentPanel? = .home
}

enum TeacherPanel: Hashable {
    case home
    case schedule
    case students
    case songs
    case myLessons
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
                case .home:
                    TeacherHomeScreen()
                case .schedule:
                    ScheduleScreen(userType: .teacher)
                case .students:
                    MyStudentsScreen()
                case .songs:
                    MySongsScreen()
                case .myLessons:
                    LessonsScreen(type: .teacher(teacherId: UserDefaults.standard.string(forKey: "teacherID")!, studentId: nil))
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
