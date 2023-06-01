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
    case postStudent(student: Student)
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
        }
    }

    var method: RequestMethod {
        switch self {
        case .getStudents, .getStudentDetails:
            return .get
        case .postStudent:
            return .post
        }
    }

    var header: [String: String]? {
        switch self {
        case .getStudents, .getStudentDetails, .postStudent:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: Student? {
        switch self {
        case .getStudents, .getStudentDetails:
            return nil
        case .postStudent(let student):
            return student
        }
    }
}

