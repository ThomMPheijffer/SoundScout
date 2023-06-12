//
//  CreateLessonScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 09/06/2023.
//

import Foundation

extension CreateLessonScreen {
    class ViewModel: ObservableObject {
        @Published var showPopover = false
        @Published var allSongs = [Song]()
        
        @Published var lessonNotes = ""
        @Published var lessonDate = Date()
        @Published var songs = [Song]()
        
        func createLesson(for studentId: String) async -> Result<Lesson, RequestError> {
            guard let teacherId = UserDefaults.standard.string(forKey: "teacherID") else { print("no teacher id"); return .failure(.unknown) }
            let songIds = songs.map { $0.id }
            return await LessonsService().postLesson(lesson: .init(lessonDate: lessonDate, lessonNotes: lessonNotes, teacherId: teacherId, studentId: studentId, songIds: songIds))
        }
        
        func canContinue() -> Bool {
            return !lessonNotes.isEmpty
        }
    }
}
