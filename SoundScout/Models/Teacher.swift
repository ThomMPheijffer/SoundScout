//
//  Teacher.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

struct Teachers: Codable {
    let teachers: [Teacher]
}

struct Teacher: Codable {
    let id: String?
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let about: String
    let priorExperience: String
    let profileImage: String?
    let instrumentIds: [String]?
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case password
        case firstName
        case lastName
        case about
        case priorExperience
        case profileImage
        case instrumentIds
        case location
    }
}

struct TeacherResponse: Codable {
    let teacher: TeacherReponseNested
}

struct TeacherReponseNested: Codable {
    let userId: String
}
