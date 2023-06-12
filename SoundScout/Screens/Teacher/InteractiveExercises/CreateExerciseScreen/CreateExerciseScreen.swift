//
//  CreateExerciseScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import SwiftUI

struct CreateExerciseScreen: View {
    let songId: String
    @ObservedObject var viewModel = ViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                SSTextField(title: "Exercise name", text: $viewModel.name)
                    .padding(.bottom, 32)
                
                SSTextField(title: "Tempo", text: $viewModel.tempo)
                    .padding(.bottom, 64)
                
                Button(action: {
                    Task {
                        let result = await viewModel.postExercise(songId: songId)
                        switch result {
                        case .success(let success):
                            print(success)
                            dismiss()
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }) {
                    SSPrimaryNavigationButtonText(text: "Create exercise", isActive: viewModel.canContinue())
                }
                .disabled(!viewModel.canContinue())
                .padding(.bottom, 128)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Create exercise")
    }
}
