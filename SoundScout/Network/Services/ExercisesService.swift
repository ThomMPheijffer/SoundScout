//
//  ExercisesService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import Foundation

protocol ExercisesServiceable {
    func getExercises(songId: String) async -> Result<Exercises, RequestError>
    func postExercise(exercise: PostExercise) async -> Result<Exercise, RequestError>
    func postSong(exerciseId: String, songMultipartRequest: MultipartRequest) async -> Result<Exercise, RequestError>
}

struct ExercisesService: HTTPClient, ExercisesServiceable {
    func getExercises(songId: String) async -> Result<Exercises, RequestError> {
        await sendRequest(endpoint: ExercisesEndpoint.getExercises(songId: songId), responseModel: Exercises.self)
    }
    
    func postExercise(exercise: PostExercise) async -> Result<Exercise, RequestError> {
        await sendRequest(endpoint: ExercisesEndpoint.postExercise(exercise: exercise), responseModel: Exercise.self)
    }
    
    func postSong(exerciseId: String, songMultipartRequest: MultipartRequest) async -> Result<Exercise, RequestError> {
        await sendRequest(endpoint: ExercisesEndpoint.postSong(exerciseId: exerciseId, songMultipartRequest: songMultipartRequest), responseModel: Exercise.self)
    }
}
