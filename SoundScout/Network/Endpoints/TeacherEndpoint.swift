//
//  TeacherEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

enum TeacherEndpoint {
    case allTeachers
    case teacherDetail(id: Int)
}

extension TeacherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .allTeachers:
            return "/teachers"
        case .teacherDetail(let id):
            return "/teachers/\(id)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .allTeachers, .teacherDetail:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .allTeachers, .teacherDetail:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .allTeachers, .teacherDetail:
            return nil
        }
    }
}

