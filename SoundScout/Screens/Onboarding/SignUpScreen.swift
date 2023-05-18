//
//  SignUpScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/05/2023.
//

import SwiftUI

struct SignUpScreen: View {
    @State private var selectedIndex = 0
    
    var body: some View {
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
                    
                    NavigationLink(destination: Text("LoginScreen")) {
                        SSSecondaryNavigationButtonText(text: "Login")
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 32)
                
                Text("Looking for?")
                    .font(.title3)
                HStack {
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 0)
                    Spacer()
                        .frame(width: 32)
                    SSSegmentedControlButton(selectedIndex: $selectedIndex, index: 1)
                }
                .padding(.top, 8)
                .padding(.bottom, 32)
                
                SSTextField(title: "First name", text: .constant(""))
                    .padding(.bottom, 16)
                SSTextField(title: "Surname", text: .constant(""))
                    .padding(.bottom, 16)
                SSTextField(title: "Email", text: .constant(""))
                    .padding(.bottom, 16)
                SSTextField(title: "Password", text: .constant(""))
                    .padding(.bottom, 16)
                
                Spacer()
                
                NavigationLink(destination: Text("Continue")) {
                    SSPrimaryNavigationButtonText(text: "Continue")
                }
            }
            .padding(.horizontal)
            
        }
        .padding()
        .padding(.leading)
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
