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
    let feedback: PractiseFeedback?
    let sound: String?
    
    var date: Date {
        return Date(timeIntervalSince1970: Double(createdAt) * 0.001)
    }
    
    var similarityGrade: Int {
        min(10, Int(((feedback?.similarity ?? 0.0) * 10) + 1))
    }
    
    var tempoGrade: Int {
        if (feedback?.originalTempo ?? 0 + 5) < feedback?.coverTempo ?? 0 {
            return 5
        } else if(feedback?.coverTempo ?? 0 + 5) < feedback?.originalTempo ?? 0 {
            return 5
        } else {
            return 10
        }
    }
    
    var chordsGrade: Double {
        guard let chords = feedback?.chord else { return 1.0 }
        var partialWrong: Double = 0.0
        var wrong: Double = 0.0
        for (_, feedback) in chords {
            if feedback.contains("Wrong") {
                wrong += 1
            } else if feedback.contains("instead") {
                partialWrong += 1
            }
        }
        let totalWrong = wrong + (partialWrong / 2)
        if totalWrong == 0 {
            return 10
        } else {
            return (1 - (totalWrong / Double(chords.count))) * 10
        }
    }
    
    var grade: Int {
        Int((Double(similarityGrade) + Double(tempoGrade) + chordsGrade) / 3)
    }
    
    var tempoFeedback: String {
        if (feedback?.originalTempo ?? 0 + 5) < feedback?.coverTempo ?? 0 {
            return "You played the song too fast.\nTarget tempo: \(Int(feedback?.originalTempo ?? 0)).\nYour tempo: \(Int(feedback?.coverTempo ?? 0))"
        } else if(feedback?.coverTempo ?? 0 + 5) < feedback?.originalTempo ?? 0 {
            return "You played the song too slow.\nTarget tempo: \(Int(feedback?.originalTempo ?? 0)).\nYour tempo: \(Int(feedback?.coverTempo ?? 0))"
        } else {
            return "Perfect tempo!"
        }
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

func convertExercisesToChartData(exercises: [ExercisePractise]) -> [ChartExerciseModel] {
    var chartModel = [ChartExerciseModel]()
    for i in -6..<1 {
        let date = Calendar.current.date(byAdding: .day, value: i, to: Date())!
        let exercises = exercises.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
        let sortedExercises = exercises.sorted { $0.grade > $1.grade }.sorted { $0.tempo > $1.tempo }
        chartModel.append(.init(date: date, grade: sortedExercises.first?.grade ?? 0, bpm: sortedExercises.first?.tempo ?? 0))
    }
    return chartModel
}

func convertExercisesToChartDataForPractises(exercises: [ExercisePractise]) -> [ChartModel] {
    var chartModel = [ChartModel]()
    for i in -6..<1 {
        let date = Calendar.current.date(byAdding: .day, value: i, to: Date())!
        let exercises = exercises.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
        chartModel.append(.init(date: date, practiseCount: exercises.count))
    }
    return chartModel
}

struct ChartExerciseModel: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let grade: Int
    let bpm: Int
}

struct ChartModel: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let practiseCount: Int
}
