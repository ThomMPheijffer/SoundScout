//
//  StudentEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

enum StudentEndpoint {
    case getStudents
    case getStudentDetails(id: String)
    case postStudent(studentMultipartForm: MultipartRequest)
    case addTeacherToStudent(studentId: String, body: AddTeacherToStudentModel)
    case getTeachers(studentId: String)
}

extension StudentEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getStudents:
            return "/students"
        case .getStudentDetails(let id):
            return "/students/user/\(id)"
        case .postStudent:
            return "/students/sign-up-student"
        case .addTeacherToStudent(let studentId, _), .getTeachers(let studentId):
            return "/students/user/\(studentId)/teachers"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getStudents, .getStudentDetails, .getTeachers:
            return .get
        case .postStudent:
            return .post
        case .addTeacherToStudent:
            return .put
        }
    }

    var header: [String: String]? {
        switch self {
        case .getStudents, .getStudentDetails, .postStudent, .addTeacherToStudent, .getTeachers:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getStudents, .getStudentDetails, .getTeachers, .postStudent:
            return nil
        case .addTeacherToStudent(_, let teacherId):
            return teacherId
        }
    }
    
    var multipartRequest: MultipartRequest? {
        switch self {
        case .getStudents, .getStudentDetails, .getTeachers, .addTeacherToStudent:
            return nil
        case .postStudent(let multipart):
            return multipart
        }
    }
}

