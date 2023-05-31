//
//  TeacherEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

enum TeacherEndpoint {
    case getTeachers
    case getTeacherDetails(id: Int)
}

extension TeacherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getTeachers:
            return "/teachers"
        case .getTeacherDetails(let id):
            return "/teachers/\(id)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getTeachers, .getTeacherDetails:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .getTeachers, .getTeacherDetails:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getTeachers, .getTeacherDetails:
            return nil
        }
    }
}

