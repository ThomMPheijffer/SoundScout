//
//  ExercisesService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import Foundation

protocol ExercisesServiceable {
    func getExercises(songId: String) async -> Result<Exercises, RequestError>
}

struct ExercisesService: HTTPClient, ExercisesServiceable {
    func getExercises(songId: String) async -> Result<Exercises, RequestError> {
        await sendRequest(endpoint: ExercisesEndpoint.getExercises(songId: songId), responseModel: Exercises.self)
    }
}
