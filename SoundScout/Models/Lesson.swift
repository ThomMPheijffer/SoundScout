//
//  Lesson.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 09/06/2023.
//

import Foundation

struct Lessons: Codable {
    let lessons: [Lesson]
}

struct Lesson: Codable, Identifiable {
    var id: String { lessonId }
    
    let lessonId: String
    let lessonDate: Date
    let lessonNotes: String
    let teacherId: String
    let studentId: String
    let songs: [Song]?
}

struct PostLesson: Codable {
    let lessonDate: Date
    let lessonNotes: String
    let teacherId: String
    let studentId: String
    let songIds: [String]?
}

struct LessonWrapper: Identifiable, Hashable {
    static func == (lhs: LessonWrapper, rhs: LessonWrapper) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    var lessons: [Lesson]
}
