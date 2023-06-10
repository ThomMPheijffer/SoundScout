//
//  CreateLessonScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 09/06/2023.
//

import Foundation

extension CreateLessonScreen {
    class ViewModel: ObservableObject {
        @Published var lessonNotes = ""
        @Published var lessonDate = Date()
        
        func createLesson(for studentId: String) async -> Result<Lesson, RequestError> {
            guard let teacherId = UserDefaults.standard.string(forKey: "teacherID") else { print("no teacher id"); return .failure(.unknown) }
            return await LessonsService().postLesson(lesson: .init(lessonDate: lessonDate, lessonNotes: lessonNotes, teacherId: teacherId, studentId: studentId, songIds: nil))
        }
    }
}
