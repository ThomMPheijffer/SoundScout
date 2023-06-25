//
//  ExercisePractise.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/06/2023.
//

import Foundation

struct ExercisePractises: Codable {
    let exercisePractises: [ExercisePractise]
}

struct ExercisePractise: Codable {
    let createdAt: Int
    let exerciseId: String
    let studentId: String
    let tempo: Int
    let feedback: PractiseFeedback
    let sound: String
    
    var date: Date {
        return Date(timeIntervalSince1970: Double(createdAt) * 0.001)
    }
}

struct PractiseFeedback: Codable {
    let originalTempo: Double
    let coverTempo: Double
    let similarity: Double
    let chord: [String: String]
}

struct PostExercisePractise: Codable {
    let exerciseId: String
    let studentId: String
    let tempo: Int
}
