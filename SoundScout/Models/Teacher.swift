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
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let about: String
    let priorExperience: String
    let profileImage: String?
    let location: Location
}

struct TeacherResponse: Codable {
    let teacher: TeacherReponseNested
}

struct TeacherReponseNested: Codable {
    let userId: String
}
