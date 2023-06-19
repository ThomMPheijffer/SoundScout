//
//  ExercisePractise.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/06/2023.
//

import Foundation

struct ExercisePractises: Codable {
    let practises: [ExercisePractise]
}

struct ExercisePractise: Codable {
    let exerciseId: String
    let studentId: String
    let tempo: Int
}

struct PostExercisePractise: Codable {
    let exerciseId: String
    let studentId: String
    let tempo: Int
}
