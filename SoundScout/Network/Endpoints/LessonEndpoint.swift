//
//  LessonEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 09/06/2023.
//

import Foundation

enum LessonEndpoint {
    case getLessons(userId: String)
    case getLessonsForSpecificUser(userId: String, secondUserId: String)
    case postLesson(lesson: PostLesson)
}

extension LessonEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getLessons(let id):
            return "/lessons/user/\(id)"
        case .getLessonsForSpecificUser(let id, let secondId):
            return "/lessons/user/\(id)/user/\(secondId)"
        case .postLesson:
            return "/lessons"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getLessons, .getLessonsForSpecificUser:
            return .get
        case .postLesson:
            return .post
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getLessons, .getLessonsForSpecificUser:
            return nil
        case .postLesson(let lesson):
            return lesson
        }
    }
}

