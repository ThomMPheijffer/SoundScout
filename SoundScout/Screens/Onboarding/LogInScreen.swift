//
//  LogInScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 18.5.23..
//

import SwiftUI

struct LogInScreen: View {
  @State private var email = ""
  @State private var password = ""
  
  var body: some View {
    HStack {
      OnboardingSidebar()
      
      Spacer()
      
      SSContentBackground {
        Text("Log in")
          .font(.largeTitle)
          .bold().padding(.bottom, 64)
        
        
        SSTextField(title: "Email", text: $email)
          .padding(.bottom, 16)
        SSTextField(title: "Password", text: $password)
          .padding(.bottom, 16)
        
        Text("Forgot password?").foregroundColor(SSColors.blue)

        
        Spacer()
        
        NavigationLink(destination: Text("Log in")) {
          SSPrimaryNavigationButtonText(text: "Log in")
        }
      }
      .padding(.horizontal)
      
    }
    .padding()
    .padding(.leading)
  }
}

struct LogInScreen_Previews: PreviewProvider {
  static var previews: some View {
    LogInScreen()
  }
}

