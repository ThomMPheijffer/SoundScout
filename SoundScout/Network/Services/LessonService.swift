//
//  LessonService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 09/06/2023.
//

protocol LessonsServiceable {
    func getLessons(userId: String) async -> Result<Lessons, RequestError>
    func getLessonsForSpecificUser(userId: String, secondUserId: String) async -> Result<Lessons, RequestError>
    func postLesson(lesson: PostLesson) async -> Result<Lesson, RequestError>
}

struct LessonsService: HTTPClient, LessonsServiceable {
    func getLessons(userId: String) async -> Result<Lessons, RequestError> {
        await sendRequest(endpoint: LessonEndpoint.getLessons(userId: userId), responseModel: Lessons.self)
    }
    
    func getLessonsForSpecificUser(userId: String, secondUserId: String) async -> Result<Lessons, RequestError> {
        await sendRequest(endpoint: LessonEndpoint.getLessonsForSpecificUser(userId: userId, secondUserId: secondUserId), responseModel: Lessons.self)
    }
    
    func postLesson(lesson: PostLesson) async -> Result<Lesson, RequestError> {
        await sendRequest(endpoint: LessonEndpoint.postLesson(lesson: lesson), responseModel: Lesson.self)
    }
}
