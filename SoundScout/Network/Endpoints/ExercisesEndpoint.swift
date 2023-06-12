//
//  ExercisesEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import Foundation

enum ExercisesEndpoint {
    case getExercises(songId: String)
}

extension ExercisesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getExercises(let id):
            return "/exercises/song/\(id)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getExercises:
            return .get
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getExercises:
            return nil
        }
    }
}

