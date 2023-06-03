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
    case postTeacher(teacher: SignUpTeacher)
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
        }
    }

    var method: RequestMethod {
        switch self {
        case .getTeachers, .getTeacherDetails:
            return .get
        case .postTeacher:
            return .post
        }
    }

    var header: [String: String]? {
        switch self {
        case .getTeachers, .getTeacherDetails, .postTeacher:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: SignUpTeacher? {
        switch self {
        case .getTeachers, .getTeacherDetails:
            return nil
        case .postTeacher(let teacher):
            return teacher
        }
    }
}

