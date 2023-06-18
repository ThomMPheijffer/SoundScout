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
    case postSong(exerciseId: String, songMultipartRequest: MultipartRequest)
}

extension ExercisesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getExercises(let id):
            return "/exercises/song/\(id)"
        case .postExercise:
            return "/exercises"
        case .postSong(let id, _):
            return "/exercises/\(id)/add-sound"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getExercises:
            return .get
        case .postExercise, .postSong:
            return .post
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getExercises, .postSong:
            return nil
        case .postExercise(let exercise):
            return exercise
        }
    }
    
    var multipartRequest: MultipartRequest? {
        switch self {
        case .getExercises, .postExercise:
            return nil
        case .postSong(_, let song):
            return song
        }
    }
}

