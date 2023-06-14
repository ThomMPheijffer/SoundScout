//
//  TeacherEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

enum TeacherEndpoint {
    case getTeachers
    case getTeacherDetails(id: String)
    case postTeacher(teacherMultipartForm: MultipartRequest)
    case getStudents(teacherId: String)
}

extension TeacherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getTeachers:
            return "/teachers"
        case .getTeacherDetails(let id):
            return "/teachers/user/\(id)"
        case .postTeacher:
            return "/teachers/sign-up-teacher"
        case .getStudents(teacherId: let id):
            return "/teachers/user/\(id)/students"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getTeachers, .getTeacherDetails, .getStudents:
            return .get
        case .postTeacher:
            return .post
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getTeachers, .getTeacherDetails, .getStudents, .postTeacher:
            return nil
        }
    }
    
    var multipartRequest: MultipartRequest? {
        switch self {
        case .getTeachers, .getTeacherDetails, .getStudents:
            return nil
        case .postTeacher(let multipartform):
            return multipartform
        }
    }
}

