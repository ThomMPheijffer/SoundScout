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
    let feedback: [String:String]
    let similarity: String
    let sound: String
}

struct PostExercisePractise: Codable {
    let exerciseId: String
    let studentId: String
    let tempo: Int
}
