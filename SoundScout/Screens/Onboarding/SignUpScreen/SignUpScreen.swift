//
//  SignUpScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct SignUpScreen: View {
    @State private var selectedIndex = 0
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            HStack {
                OnboardingSidebar()
                
                Spacer()
                
                SSContentBackground {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                    
                    HStack {
                        Text("Have an account already?")
                        
                        Spacer()
                        
                        NavigationLink(destination: LogInScreen()) {
                            SSSecondaryNavigationButtonText(text: "Login")
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 32)
                    
                    Text("Looking for?")
                        .font(.title3)
                    HStack {
                        SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 0, text: "Learning an instrument")
                        Spacer()
                            .frame(width: 32)
                        SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 1, text: "Teaching an instrument")
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 32)
                    
                    SSTextField(title: "First name", text: $viewModel.firstName)
                        .padding(.bottom, 16)
                    SSTextField(title: "Surname", text: $viewModel.surname)
                        .padding(.bottom, 16)
                    SSTextField(title: "Email", text: $viewModel.email)
                        .padding(.bottom, 16)
                    SSTextField(title: "Password", text: $viewModel.password, isSecured: true)
                        .padding(.bottom, 16)
                    
                    Spacer()
                    
                    NavigationLink(destination: destinationForSelectionView) {
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
    
    // Variable to determine destination based on selection
    @ViewBuilder
    var destinationForSelectionView: some View {
        if selectedIndex == 0 {
            CreateStudentProfileScreen(basicUserInfo: viewModel.basicSignUpInformation())
        } else {
            CreateTeacherProfileScreen(basicUserInfo: viewModel.basicSignUpInformation())
        }
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
