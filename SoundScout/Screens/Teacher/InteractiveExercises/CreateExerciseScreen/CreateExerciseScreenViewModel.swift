//
//  CreateExerciseScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import Foundation

extension CreateExerciseScreen {
    class ViewModel: ObservableObject {
        @Published var name: String = ""
        
        func postExercise(songId: String, tempo: Int) async -> Result<Exercise, RequestError> {
            let result = await ExercisesService().postExercise(exercise: .init(songId: songId, title: name, tempo: tempo))
            return result
        }
        
        func canContinue() -> Bool {
            return !name.isEmpty
        }
    }
}
