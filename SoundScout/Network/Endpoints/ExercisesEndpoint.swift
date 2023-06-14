//
//  ExercisesEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import Foundation

enum ExercisesEndpoint {
    case getExercises(songId: String)
    case postExercise(exercise: PostExercise)
}

extension ExercisesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getExercises(let id):
            return "/exercises/song/\(id)"
        case .postExercise:
            return "/exercises"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getExercises:
            return .get
        case .postExercise:
            return .post
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getExercises:
            return nil
        case .postExercise(let exercise):
            return exercise
        }
    }
}

