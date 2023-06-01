//
//  ProfileScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 18.5.23..
//

import SwiftUI

struct CreateTeacherProfileScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var spotify: Spotify
    
    let basicUserInfo: BasicSignUpInformation
    @ObservedObject var viewModel = ViewModel()
    
    @State private var selectedIndex = 0
    
    var body: some View {
        HStack {
            OnboardingSidebar()
            
            Spacer()
            
            SSContentBackground {
                HStack {
                    Text("Profile")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink(destination: Text("Profile picture")) {
                        SSSecondaryNavigationButtonText(text: "Select profile picture")
                    }
                }.padding(.bottom, 64)
                
                SSTextField(title: "About", text: $viewModel.about, axis: .vertical)
                    .padding(.bottom, 16)
                
                SSTextField(title: "Relevant education/prior experience", text: $viewModel.priorExperience, axis: .vertical)
                    .padding(.bottom, 16)
                
//                Text("I prefer teaching")
//                    .font(.title3)
//                    .padding(.bottom, 16)
//                HStack {
//                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 0, text: "Online")
//                    Spacer()
//                        .frame(width: 16)
//                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 1, text: "In-person")
//                    Spacer()
//                        .frame(width: 16)
//                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 2, text: "Both")
//                }
//                .padding(.top, 8)
//                .padding(.bottom, 32)
                
                Text("I can teach")
                    .font(.title3)
                    .padding(.bottom, 16)
                NavigationLink(destination: SelectInstrumentsScreen()) {
                    SSSecondaryNavigationButtonText(text: "Select instruments", fullWidth: true)
                }
                .padding(.bottom, 32)
                
                
                
                Spacer()
                
                Button(action: {
                    Task {
                        let result = await viewModel.login(basicInfo: basicUserInfo)
                        switch result {
                        case .success(let success):
                            print(success)
                            UserDefaults.standard.set(success.teacher.userId, forKey: "teacherUserID")
                            UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = UIHostingController(rootView: TeacherContentView().environmentObject(navigationManager).environmentObject(spotify))
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                    
                }) {
                    SSPrimaryNavigationButtonText(text: "Continue", isActive: viewModel.canContinue())
                }
                .disabled(!viewModel.canContinue())
                
//                NavigationLink(destination: TeacherContentView(), isActive: $viewModel.navigationIsActive) { EmptyView() }
            }
            .padding(.horizontal)
            
        }
        .padding()
        .padding(.leading)
    }
}

struct CreateTeacherProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeacherProfileScreen(basicUserInfo: .init(firstname: "", surname: "", email: "", password: ""))
    }
}


