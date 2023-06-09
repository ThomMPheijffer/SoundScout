//
//  StudentProfileScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 20.5.23..
//

import SwiftUI

struct CreateStudentProfileScreen: View {
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var spotify: Spotify
    
    let basicUserInfo: BasicSignUpInformation
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        HStack {
            OnboardingSidebar()
            
            Spacer()
            
            SSContentBackground {
                ScrollView {
                    HStack {
                        Text("Profile")
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                        
                        if viewModel.imageUrl != nil {
                            Image(uiImage: .init(data: try! .init(contentsOf: viewModel.imageUrl!))!)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                                .background {
                                    Circle().fill(
                                        LinearGradient(
                                            colors: [.yellow, .orange],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                }
                        } else {
                            Button(action: {  viewModel.showingImagePicker = true }) {
                                SSSecondaryNavigationButtonText(text: "Select profile picture")
                            }
                            .sheet(isPresented: $viewModel.showingImagePicker) {
                                SSImagePicker(selectedImageURL: $viewModel.imageUrl)
                            }
                        }
                        
                    }.padding(.bottom, 64)
                    
                    SSTextField(title: "About", text: $viewModel.about, axis: .vertical)
                        .padding(.bottom, 16)
                    
                    SSTextField(title: "Prior experience", text: $viewModel.priorExperience, axis: .vertical)
                        .padding(.bottom, 16)
                    
                    Text("I want to learn")
                        .font(.title3)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(destination: SelectInstrumentsScreen(selectedIds: $viewModel.selectedInstrumentIds)) {
                        SSSecondaryNavigationButtonText(text: "Select instruments \(viewModel.selectedInstrumentIds.count > 0 ? "(\(viewModel.selectedInstrumentIds.count) selected)": "")", fullWidth: true)
                    }
                    .padding(.bottom, 64)
                    
//                    Group {
//                        Text("Connect with Spotify")
//                            .font(.title3)
//                            .padding(.bottom)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        
//                        if spotify.isAuthorized {
//                            Text("Connected with Spotify")
//                                .foregroundColor(.secondary)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        } else {
//                            Button(action: {
//                                spotify.authorize()
//                            }) {
//                                Text("Authorize Spotify")
//                            }
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        }
//                    }
//                    .padding(.bottom, 16)
                    
//                    Group {
//                        Text("Location")
//                            .font(.title3)
//                            .padding(.bottom)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        
//                        if locationManager.location != nil {
//                            Text("\(viewModel.city), \(viewModel.state)")
//                                .foregroundColor(.secondary)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        } else {
//                            Button(action: {
//                                locationManager.requestLocation()
//                            }) {
//                                SSPrimaryNavigationButtonText(text: "Give access to current location", fullWidth: false)
//                            }
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        }
//                    }
//                    .padding(.bottom, 64)
                    
                    Button(action: {
                        Task {
                            let result = await viewModel.signUp(basicInfo: basicUserInfo)
                            switch result {
                            case .success(let success):
                                print(success)
                                UserDefaults.standard.set(success.student.userId, forKey: "studentUserID")
                                UserDefaults.standard.set(success.student.id, forKey: "studentID")
                                
                                let vc = UIHostingController(rootView: StudentContentView().environmentObject(navigationManager).environmentObject(spotify))
                                replaceKeyWindow(with: vc)
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                        
                    }) {
                        SSPrimaryNavigationButtonText(text: "Continue", isActive: viewModel.canContinue())
                    }
                    .disabled(!viewModel.canContinue())
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
            
        }
        .padding()
        .padding(.leading)
//        .onChange(of: locationManager.location) { newValue in
//            viewModel.getCityName(for: locationManager.location)
//        }
    }
    
}

struct CreateStudentProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateStudentProfileScreen(basicUserInfo: .init(firstname: "", surname: "", email: "", password: ""))
    }
}
