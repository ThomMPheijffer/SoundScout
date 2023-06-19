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
//    case songs
    case myLessons
    case profile
//    case myMessages
}

struct StudentContentView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    var body: some View {
        NavigationSplitView {
            StudentSidebar(selection: $navigationManager.studentSelection)
        } detail: {
            NavigationStack {
                switch navigationManager.studentSelection {
                case .home:
                    StudentHomeScreen()
                case .schedule:
                    Text("Schedule")
                case .myTeachers:
                    MyTeachersScreen()
                case .findTeachers:
                    FindTeachersScreen()
//                case .songs:
//                    MySongsScreen()
                case .myLessons:
                    LessonsScreen(type: .student(studentId: UserDefaults.standard.string(forKey: "studentID")!, teacherId: nil))
                case .profile:
                    StudentProfileScreen()
                    //            case .myMessages:
                    //                StudentProfileScreen()
                default:
                    Text("Default")
                }
            }
        }
    }
}

struct StudentContentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentContentView()
    }
}


