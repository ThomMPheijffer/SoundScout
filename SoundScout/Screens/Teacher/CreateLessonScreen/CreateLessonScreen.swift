//
//  CreateLessonScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 09/06/2023.
//

import SwiftUI

struct CreateLessonScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    let studentId: String
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            SSContentBackground {
                SSTextField(title: "Lesson notes", text: $viewModel.lessonNotes, axis: .vertical)
                
                Text("Date")
                    .font(.title3)
                    .padding(.top, 64)
                    .padding(.bottom)
                DatePicker(selection: $viewModel.lessonDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Select a date")
                }
                .labelsHidden()
                
                Text("Songs")
                    .font(.title3)
                    .padding(.top, 64)
                    .padding(.bottom)
                NavigationLink(destination: Text("Select songs")) {
                    SSSecondaryNavigationButtonText(text: "Select songs")
                }
                
                Button(action: {
                    Task {
                        let result = await viewModel.createLesson(for: studentId)
                        switch result {
                        case .success(let success):
                            print(success)
                            dismiss()
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }) {
                    SSPrimaryNavigationButtonText(text: "Create lesson", isActive: viewModel.canContinue())
                }
                .disabled(!viewModel.canContinue())
                .padding(.top, 128)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Create lesson")
    }
}

struct CreateLessonScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateLessonScreen(studentId: "")
    }
}
