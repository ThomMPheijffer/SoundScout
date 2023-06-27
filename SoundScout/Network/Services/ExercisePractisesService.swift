//
//  ExercisePractisesService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/06/2023.
//

import Foundation

protocol ExercisePractisesServiceable {
    func getExercisePractises(exerciseId: String, studentId: String) async -> Result<ExercisePractises, RequestError>
    func postExercisePractiseBala(practiseMultipartRequest: MultipartRequest) async -> Result<ExercisePractise, RequestError>
}

struct ExercisePractisesService: HTTPClient, ExercisePractisesServiceable {
    func getExercisePractises(exerciseId: String, studentId: String) async -> Result<ExercisePractises, RequestError> {
        await sendRequest(endpoint: ExercisePractisesEndpoint.getExercisePractises(exerciseId: exerciseId, studentId: studentId), responseModel: ExercisePractises.self)
    }
    
    func postExercisePractise(practiseMultipartRequest: MultipartRequest) async -> Result<ExercisePractise, RequestError> {
        await sendRequest(endpoint: ExercisePractisesEndpoint.postExercisePractise(practiseMultipartRequest: practiseMultipartRequest), responseModel: ExercisePractise.self)
    }
    
    func postExercisePractiseBala(practiseMultipartRequest: MultipartRequest) async -> Result<ExercisePractise, RequestError> {
        await sendRequest(endpoint: ExercisePractisesEndpoint.postExercisePractiseBala(practiseMultipartRequest: practiseMultipartRequest), responseModel: ExercisePractise.self)
    }
}
