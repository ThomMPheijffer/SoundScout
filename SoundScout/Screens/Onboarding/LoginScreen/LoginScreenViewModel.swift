//
//  LoginScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 01/06/2023.
//

import Foundation
import UIKit

extension LogInScreen {
    class ViewModel: ObservableObject {
        @Published var email: String = ""
        @Published var password: String = ""
        
        func login() async -> Result<LoginResponse, RequestError> {
            return await UsersService().login(credentials: .init(email: email, password: password))
        }
    }
}
