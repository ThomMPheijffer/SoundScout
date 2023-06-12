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
        @Published var tempo: String = ""
        
        func postExercise(songId: String) async -> Result<Exercise, RequestError> {
            let result = await ExercisesService().postExercise(exercise: .init(songId: songId, title: name, tempo: Int(tempo)!))
            return result
        }
        
        func canContinue() -> Bool {
            return !name.isEmpty && !tempo.isEmpty && (Int(tempo) != nil)
        }
    }
}
