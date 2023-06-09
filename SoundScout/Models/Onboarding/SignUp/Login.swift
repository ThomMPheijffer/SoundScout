//
//  Login.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 01/06/2023.
//

import Foundation

struct LoginCredentials: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let userId: String
    let studentId: String?
    let teacherId: String?
    let isTeacher: Bool
    let isStudent: Bool
}
