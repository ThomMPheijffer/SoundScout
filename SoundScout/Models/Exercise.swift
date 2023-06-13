//
//  Exercise.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import Foundation

struct Exercises: Codable {
    let exercises: [Exercise]
}

struct Exercise: Codable {
    let id: String
    let songId: String
    let title: String
    let tempo: Int
}

struct PostExercise: Codable {
    let songId: String
    let title: String
    let tempo: Int
}

struct DocumentUpload: Codable {
    let document: Data
}
