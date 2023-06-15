//
//  CreateStudentProfileScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation
import UIKit
import SwiftUI
import CoreLocation

extension CreateStudentProfileScreen {
    class ViewModel: ObservableObject {
        @Published var about: String = ""
        @Published var priorExperience: String = ""
        @Published var selectedInstrumentIds: [String] = []
        
        @Published var city: String = ""
        @Published var state: String = ""
        @Published var showingImagePicker = false
        @Published var imageUrl: URL? = nil
        @Published var location: CLLocationCoordinate2D? = nil
        
        func canContinue() -> Bool {
            return !about.isEmpty && !priorExperience.isEmpty && location != nil && imageUrl != nil
        }
        
        func signUp(basicInfo: BasicSignUpInformation) async -> Result<StudentResponse, RequestError> {
            let student = SignUpStudent(email: basicInfo.email,
                                        password: basicInfo.password,
                                        firstName: basicInfo.firstname,
                                        lastName: basicInfo.surname,
                                        about: about,
                                        priorExperience: priorExperience,
                                        instrumentIds: selectedInstrumentIds,
                                        location: .init(latitude: location!.latitude, longitude: location!.longitude, city: city, state: state))
            
            #warning("reduce quality")
            let imageData = try! Data(contentsOf: imageUrl!)
            
            
            var multipart = MultipartRequest()
            multipart.add(key: "payload", value: student.stringified())
            multipart.add(key: "profilePicture", fileName: "\(UUID().uuidString).jpeg", fileMimeType: "image/jpeg", fileData: imageData)
            
            let result = await StudentsService()
                .postStudent(studentMultipartForm: multipart)
            
            return result
        }
        
        func getCityName(for optionalLocation: CLLocationCoordinate2D?) {
            guard let lastLocation = optionalLocation else { return }
            self.location = lastLocation
            
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
            
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print(error)
                }
                
                guard let placemark = placemarks?.first else { return }
                guard let city = placemark.locality else { return }
                guard let state = placemark.administrativeArea else { return }
                
                self.city = city
                self.state = state
            }
        }
    }
}
