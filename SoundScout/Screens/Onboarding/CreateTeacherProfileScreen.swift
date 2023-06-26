//
//  ProfileScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 18.5.23..
//

import SwiftUI

struct CreateTeacherProfileScreen: View {
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
                    VStack(alignment: .leading) {
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
                        
                        SSTextField(title: "Relevant education/prior experience", text: $viewModel.priorExperience, axis: .vertical)
                            .padding(.bottom, 16)
                        
                        SSTextField(title: "Hourly rate", text: $viewModel.hourlyRate)
                            .padding(.bottom, 16)
                        
                        Text("I can teach")
                            .font(.title3)
                            .padding(.bottom, 16)
                        NavigationLink(destination: SelectInstrumentsScreen(selectedIds: $viewModel.selectedInstrumentIds)) {
                            SSSecondaryNavigationButtonText(text: "Select instruments \(viewModel.selectedInstrumentIds.count > 0 ? "(\(viewModel.selectedInstrumentIds.count) selected)": "")", fullWidth: true)
                        }
                        .padding(.bottom, 16)
                        
                        Group {
                            Text("Connect with Spotify")
                                .font(.title3)
                                .padding(.bottom)
                            
                            if spotify.isAuthorized {
                                Text("Connected with Spotify")
                                    .foregroundColor(.secondary)
                            } else {
                                Button(action: {
                                    spotify.authorize()
                                }) {
                                    Text("Authorize Spotify")
                                }
                            }
                        }
                        .padding(.bottom, 16)
                        
                        Text("Location")
                            .font(.title3)
                            .padding(.bottom, 8)
                        
                        Group {
                            if locationManager.location != nil {
                                Text("\(viewModel.city), \(viewModel.state)")
                                    .foregroundColor(.secondary)
                            } else {
                                Button(action: {
                                    locationManager.requestLocation()
                                }) {
                                    SSPrimaryNavigationButtonText(text: "Give access to current location", fullWidth: false)
                                }
                            }
                        }
                        .padding(.bottom, 64)
                        
                        Button(action: {
                            Task {
                                let result = await viewModel.signUp(basicInfo: basicUserInfo)
                                switch result {
                                case .success(let success):
                                    print(success)
                                    UserDefaults.standard.set(success.teacher.userId, forKey: "teacherUserID")
                                    UserDefaults.standard.set(success.teacher.id, forKey: "teacherID")
                                    
                                    let vc = UIHostingController(rootView: TeacherContentView().environmentObject(navigationManager).environmentObject(spotify))
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
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
            
        }
        .padding()
        .padding(.leading)
        .onChange(of: locationManager.location) { newValue in
            viewModel.getCityName(for: locationManager.location)
        }
    }
}

struct CreateTeacherProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeacherProfileScreen(basicUserInfo: .init(firstname: "", surname: "", email: "", password: ""))
    }
}


