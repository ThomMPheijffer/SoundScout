//
//  StudentLessonsScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct LessonsScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    enum UserType {
        case student(studentId: String, teacherId: String?)
        case teacher(teacherId: String, studentId: String?)
    }
    
    let type: UserType
    
//    let studentId: String?
//    let teacherId: String?
//    let canCreateLesson: Bool
//    
//    init(studentId: String? = nil, teacherId: String? = nil, canCreateLesson: Bool = true) {
//        self.studentId = studentId
//        self.teacherId = teacherId
//        self.canCreateLesson = canCreateLesson
//    }
    
    @State var lessonWrapper = [LessonWrapper]()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(lessonWrapper, id: \.self) { wrapper in
                    Text(wrapper.lessons.first!.lessonDate.getMonthYearString())
                        .font(.headline)
                        .bold()
                    
                    SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
                        ForEach(0..<wrapper.lessons.count, id: \.self) { i in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(wrapper.lessons[i].lessonDate, style: .date)
                                    
                                    if let profilePicture = URL(string: wrapper.lessons[i].profilePicture ?? "") {
                                        AsyncImage(url: profilePicture) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Circle()
                                                .fill(SSColors.blue)
                                                .opacity(0.1)
                                        }
                                        
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(15)
                                        .clipped()
                                    }
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: destinationForSelectionView(lesson: wrapper.lessons[i])) {
                                        HStack {
                                            Text("Show details")
                                            Image(systemName: "chevron.right")
                                        }
                                        .font(.callout)
                                        .bold()
                                    }
                                }
                                .padding(.vertical)
                                
                                if i != (wrapper.lessons.count - 1) {
                                    Divider()
                                        .padding(.horizontal, -32)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 32)
                }
                
            }
        }
        .padding()
        .navigationTitle("Lessons")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                switch type {
                case .teacher(_, let studentId):
                    if studentId != nil {
                            NavigationLink(destination: CreateLessonScreen(studentId: studentId!)) {
                                SSPrimaryNavigationButtonText(text: "Create lesson")
                            }
                        
                    } else {
                        EmptyView()
                    }
                default:
                    EmptyView()
                }
            }
        }
        .task {
            let result: Result<Lessons, RequestError>
            switch type {
            case .student(let studentId, let teacherId):
                if teacherId != nil {
                    print("Specific call student")
                    result = await LessonsService().getLessonsForSpecificUser(userId: teacherId!, secondUserId: studentId)
                } else {
                    print("non Specific call student")
                    result = await LessonsService().getLessons(userId: studentId)
                }
            case .teacher(let teacherId, let studentId):
                if studentId != nil {
                    print("Specific call teacher")
                    result = await LessonsService().getLessonsForSpecificUser(userId: studentId!, secondUserId: teacherId)
                } else {
                    print("non Specific call teacher")
                    result = await LessonsService().getLessons(userId: teacherId)
                }
            }
            
            switch result {
            case .success(let data):
                let groupedByMonth = Dictionary(grouping: data.lessons) { lesson in
                    lesson.lessonDate.getMonthYearString()
                }
                
                let sortedDictionary = groupedByMonth.sorted { first, second in
                    first.value.first!.lessonDate > second.value.first!.lessonDate
                }
                
                var wrapper = [LessonWrapper]()
                for (_, lessons) in sortedDictionary {
                    wrapper.append(LessonWrapper(lessons: lessons))
                }
                
                var sortedWrapper = [LessonWrapper]()
                for wrapperElement in wrapper {
                    let sortedLessons = wrapperElement.lessons.sorted { first, second in
                        first.lessonDate > second.lessonDate
                    }
                    sortedWrapper.append(LessonWrapper(lessons: sortedLessons))
                }
                
                self.lessonWrapper = sortedWrapper
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    @ViewBuilder
    func destinationForSelectionView(lesson: Lesson) -> some View {
        switch type {
        case .teacher:
            TeacherLessonDetailsScreen(lesson: lesson)
        case .student:
            StudentLessonDetailsScreen(lesson: lesson)
        }
    }
}

extension Date {
    func getMonthYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
}
