//
//  StudentProfileScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 20.5.23..
//

import SwiftUI

struct CreateStudentProfileScreen: View {
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
                
                SSTextField(title: "Prior experience", text: $viewModel.priorExperience, axis: .vertical)
                    .padding(.bottom, 16)
                
//                Text("I prefer taking lessons")
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
                
                Text("I want to learn")
                    .font(.title3)
                    .padding(.bottom, 16)
                NavigationLink(destination: SelectInstrumentsScreen()) {
                    SSSecondaryNavigationButtonText(text: "Select instruments", fullWidth: true)
                }
                .padding(.bottom, 32)
                
                Spacer()
                
                Button(action: {
                    Task {
                        let result = await viewModel.signUp(basicInfo: basicUserInfo)
                        switch result {
                        case .success(let success):
                            print(success)
                            UserDefaults.standard.set(success.student.userId, forKey: "studentUserID")
                            
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
            .padding(.horizontal)
            
        }
        .padding()
        .padding(.leading)
    }
}

struct CreateStudentProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateStudentProfileScreen(basicUserInfo: .init(firstname: "", surname: "", email: "", password: ""))
    }
}



