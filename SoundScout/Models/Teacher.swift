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

struct SignUpTeacher: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let about: String
    let priorExperience: String
    let instrumentIds: [String]?
    let location: Location
}

struct Teacher: Codable, Identifiable {
    let id: String
    let userID: String
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let about: String
    let priorExperience: String
    let profilePicture: String
    let instruments: [Instrument]
    let location: Location
}

struct TeacherResponse: Codable {
    let teacher: TeacherReponseNested
}

struct TeacherReponseNested: Codable {
    let userId: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id = "_id"
    }
}
