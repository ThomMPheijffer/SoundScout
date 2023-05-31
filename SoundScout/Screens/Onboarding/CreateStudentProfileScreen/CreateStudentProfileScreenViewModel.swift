//
//  CreateStudentProfileScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

extension CreateStudentProfileScreen {
    class ViewModel: ObservableObject {
        @Published var about: String = ""
        @Published var priorExperience: String = ""
        @Published var navigationIsActive = false
        
        func canContinue() -> Bool {
            return !about.isEmpty && !priorExperience.isEmpty
        }
        
        func login(basicInfo: BasicSignUpInformation) {
            Task {
                let result = await StudentsService()
                    .postStudent(student: .init(email: basicInfo.email,
                                                password: basicInfo.password,
                                                firstName: basicInfo.firstname,
                                                lastName: basicInfo.surname,
                                                about: about,
                                                priorExperience: priorExperience,
                                                location: .init(latitude: 1, longitude: 1)))
                
                switch result {
                case .success(let success):
                    print(success)
                    DispatchQueue.main.async { self.navigationIsActive = true }
                case .failure(let failure):
                    print(failure)
//                    DispatchQueue.main.async { self.navigationIsActive = true }
                }
            }
        }
    }
}
