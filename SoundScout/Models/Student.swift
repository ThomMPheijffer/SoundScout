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

struct Student: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let about: String
    let priorExperience: String
    let location: Location
}

struct StudentResponse: Codable {
    let student: StudentReponseNested
}

struct StudentReponseNested: Codable {
    let userId: String
}
