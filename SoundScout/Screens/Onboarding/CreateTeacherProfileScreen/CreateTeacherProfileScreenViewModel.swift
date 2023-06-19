//
//  CreateTeacherProfileScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 01/06/2023.
//

import Foundation
import UIKit
import CoreLocation

extension CreateTeacherProfileScreen {
    class ViewModel: ObservableObject {
        @Published var about: String = ""
        @Published var priorExperience: String = ""
        @Published var hourlyRate: String = ""
        @Published var selectedInstrumentIds: [String] = []
        
        @Published var city: String = ""
        @Published var state: String = ""
        @Published var showingImagePicker = false
        @Published var imageUrl: URL? = nil
        @Published var location: CLLocationCoordinate2D? = nil
        
        func canContinue() -> Bool {
            return !about.isEmpty && !priorExperience.isEmpty && location != nil && imageUrl != nil && (Int(hourlyRate) != nil)
        }
        
        func signUp(basicInfo: BasicSignUpInformation) async -> Result<TeacherResponse, RequestError> {
            let teacher = SignUpTeacher(email: basicInfo.email,
                                        password: basicInfo.password,
                                        firstName: basicInfo.firstname,
                                        lastName: basicInfo.surname,
                                        about: about,
                                        priorExperience: priorExperience,
                                        instrumentIds: selectedInstrumentIds,
                                        location: .init(latitude: location!.latitude, longitude: location!.longitude, city: city, state: state),
                                        hourlyRate: Int(hourlyRate)!)
            
            let imageData = try! Data(contentsOf: imageUrl!)
            let compressedImage = UIImage(data: imageData)!.jpegData(compressionQuality: 0.2)!
            var multipart = MultipartRequest()
            multipart.add(key: "payload", value: teacher.stringified())
            multipart.add(key: "profilePicture", fileName: "\(UUID().uuidString).jpeg", fileMimeType: "image/jpeg", fileData: compressedImage)
            
            return await TeachersService().postTeacher(teacherMultipartForm: multipart)
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
