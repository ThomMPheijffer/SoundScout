//
//  CreateStudentProfileScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation
import UIKit
import SwiftUI

extension CreateStudentProfileScreen {
    class ViewModel: ObservableObject {
        @Published var about: String = ""
        @Published var priorExperience: String = ""
        
        func canContinue() -> Bool {
            return !about.isEmpty && !priorExperience.isEmpty
        }
        
        func signUp(basicInfo: BasicSignUpInformation) async -> Result<StudentResponse, RequestError> {
            
            //                let image = UIImage(named: "profileImage")
            //                let base64String = image?.jpegData(compressionQuality: 0.1)?.base64URLEncodedString()
            //                print(base64String)
            
            let result = await StudentsService()
                .postStudent(student: .init(email: basicInfo.email,
                                            password: basicInfo.password,
                                            firstName: basicInfo.firstname,
                                            lastName: basicInfo.surname,
                                            about: about,
                                            priorExperience: priorExperience,
                                            //                                                profileImage: base64String,
                                            profileImage: nil,
                                            location: .init(latitude: 1, longitude: 1)))
            
            return result
        }
    }
}
