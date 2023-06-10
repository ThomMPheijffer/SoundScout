//
//  StudentLessonsScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct LessonsScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let student: Student?
    let teacher: Teacher?
    
    @State var lessonWrapper = [LessonWrapper]()
    
    var body: some View {
            VStack(alignment: .leading) {
                ForEach(lessonWrapper, id: \.self) { wrapper in
                    Text(wrapper.lessons.first!.lessonDate.getMonthYearString())

                    SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
                        ForEach(0..<wrapper.lessons.count, id: \.self) { i in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(wrapper.lessons[i].lessonDate, style: .date)
                                    Spacer()

                                    NavigationLink(destination: destinationForSelectionView) {
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
                
                Spacer()
            }
            .padding()
            .navigationTitle("Lessons")
            .toolbar {
                if student != nil {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CreateLessonScreen(studentId: student!.id)) {
                            SSPrimaryNavigationButtonText(text: "Create lesson")
                        }
                    }
                }
            }
            .task {
                let userId = teacher?.id ?? (student?.id ?? "")
                guard userId != "" else { fatalError("No teacher and no student mode") }
                let result = await LessonsService().getLessons(userId: userId)
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
                    
                    self.lessonWrapper = wrapper
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
    @ViewBuilder
    var destinationForSelectionView: some View {
        if teacher != nil {
            StudentLessonDetailsScreen()
        } else if student != nil {
            TeacherLessonDetailsScreen()
        } else {
            Text("No user type passed through")
        }
    }
}



struct LessonsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LessonsScreen(student: nil, teacher: nil)
    }
}

extension Date {
    func getMonthYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
}
