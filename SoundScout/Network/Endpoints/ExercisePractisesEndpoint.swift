//
//  ExercisePractisesEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/06/2023.
//

import Foundation

enum ExercisePractisesEndpoint {
    case getExercisePractises(exerciseId: String, studentId: String)
    case postExercisePractise(practiseMultipartRequest: MultipartRequest)
    case postExercisePractiseBala(practiseMultipartRequest: MultipartRequest)
}

extension ExercisePractisesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getExercisePractises(let exerciseId, let studentId):
            return "/exercisePractises/\(exerciseId)/student/\(studentId)"
        case .postExercisePractise:
            return "/exercisePractises"
        case .postExercisePractiseBala:
            return "/exercisePractises/bala"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getExercisePractises:
            return .get
        case .postExercisePractise, .postExercisePractiseBala:
            return .post
        }
    }
    
    var body: (any Codable)? {
        return nil
    }
    
    var multipartRequest: MultipartRequest? {
        switch self {
        case .getExercisePractises:
            return nil
        case .postExercisePractise(let practise), .postExercisePractiseBala(let practise):
            return practise
        }
    }
}

