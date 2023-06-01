//
//  LogInScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 18.5.23..
//

import SwiftUI

struct LogInScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var spotify: Spotify
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        HStack {
            OnboardingSidebar()
            
            Spacer()
            
            SSContentBackground {
                Text("Log in")
                    .font(.largeTitle)
                    .bold().padding(.bottom, 64)
                
                
                SSTextField(title: "Email", text: $viewModel.email)
                    .padding(.bottom, 16)
                SSTextField(title: "Password", text: $viewModel.password)
                    .padding(.bottom, 16)
                
                Text("Forgot password?").foregroundColor(SSColors.blue)
                
                
                Spacer()
                
                Button(action: {
                    Task {
                        let result = await viewModel.login()
                        switch result {
                        case .success(let success):
                            print(success)
                            if success.isTeacher {
                                UserDefaults.standard.set(success.userID, forKey: "teacherUserID")
                                
                                let vc = UIHostingController(rootView: TeacherContentView().environmentObject(navigationManager).environmentObject(spotify))
                                replaceKeyWindow(with: vc)
                            } else if success.isStudent {
                                UserDefaults.standard.set(success.userID, forKey: "studentUserID")
                                
                                let vc = UIHostingController(rootView: StudentContentView().environmentObject(navigationManager).environmentObject(spotify))
                                replaceKeyWindow(with: vc)
                            } else {
                                fatalError("No student or teacher")
                            }
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }) {
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

