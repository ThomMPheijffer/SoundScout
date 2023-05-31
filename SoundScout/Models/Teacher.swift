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
    let userId: User
}
