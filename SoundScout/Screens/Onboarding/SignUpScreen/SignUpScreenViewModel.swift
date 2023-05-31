//
//  SignUpScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

extension SignUpScreen {
    class ViewModel: ObservableObject {
        @Published var firstName: String = ""
        @Published var surname: String = ""
        @Published var email: String = ""
        @Published var password: String = ""
        
        func canContinue() -> Bool {
            return !firstName.isEmpty && !surname.isEmpty && !email.isEmpty && !password.isEmpty
        }
        
        func basicSignUpInformation() -> BasicSignUpInformation {
            return .init(firstname: firstName, surname: surname, email: email, password: password)
        }
    }
}
