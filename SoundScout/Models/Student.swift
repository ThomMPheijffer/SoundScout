//
//  Student.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

struct Students: Codable {
    let students: [Student]
}

struct SignUpStudent: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let about: String
    let priorExperience: String
    let instrumentIds: [String]
    let location: Location
}

struct Student: Codable, Identifiable {
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

struct StudentResponse: Codable {
    let student: StudentReponseNested
}

struct StudentReponseNested: Codable {
    let userId: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id = "_id"
    }
}

struct AddTeacherToStudentModel: Codable {
    let teacherId: String
}
