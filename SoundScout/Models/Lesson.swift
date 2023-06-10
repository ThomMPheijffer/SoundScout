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

struct Lesson: Codable {
    let lessonId: String
//    let lessonDate: Date
    let lessonNotes: String
    let teacherId: String
    let studentId: String
    let songIds: [Song]?
}

struct PostLesson: Codable {
    let lessonDate: Date
    let lessonNotes: String
    let teacherId: String
    let studentId: String
    let songIds: [String]?
}
