//
//  StudentProfileScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 25/05/2023.
//

import SwiftUI

struct StudentProfileScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var spotify: Spotify
    
    @State var student: Student? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                SSColors.blueInactive
                    .frame(height: 220)
                    .overlay {
                        Circle()
                            .fill(SSColors.blue)
                            .shadow(radius: 6)
                            .frame(width: 185, height: 185)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .offset(y: 110)
                    }
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Walter Nikolic")
                            .font(.title2)
                            .bold()
                        Text("The Hague, Netherlands")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: LessonsScreen(userType: .teacher)) {
                        SSPrimaryNavigationButtonText(text: "Lessons", fullWidth: false)
                    }
                    
                    Button(action: {}) {
                        SSSecondaryNavigationButtonText(text: "Chat")
                    }
                }
                .padding()
                .padding(.top, 92)
                
                SSContentBackground(padding: 16) {
                    Text("About")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies felis eu enim consequat, nec luctus enim posuere. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque hendrerit nunc nunc, at cursus tortor interdum at. Ut eget vehicula lacus. Nam non fermentum nulla.")
                        .foregroundColor(.secondary)
                }
                .padding([.horizontal, .top])
                
                SSContentBackground(padding: 16) {
                    Text("Interests")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    HStack(spacing: 64) {
                        Text("Piano")
                            .bold()
                        Text("Guitar")
                            .bold()
                        Text("Music theory")
                            .bold()
                        Text("Vocal")
                            .bold()
                        Spacer()
                    }
                    .foregroundColor(.secondary)
                }
                .padding([.horizontal, .top])
                
                SSContentBackground(padding: 16) {
                    Text("Knowlegde level")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                
                Button("Logout") {
                    UserDefaults.standard.set(nil, forKey: "studentUserID")
                    UserDefaults.standard.set(nil, forKey: "teacherUserID")
                    
                    let vc = UIHostingController(rootView: SignUpScreen().environmentObject(navigationManager).environmentObject(spotify))
                    replaceKeyWindow(with: vc)
                }
                
            }
        }
        .ignoresSafeArea(edges: .top)
//        .task {
//            guard let studentID = UserDefaults.standard.string(forKey: "studentUserID") else { return }
//            print(studentID)
//            let result = await StudentsService().getStudentDetails(id: studentID)
//            switch result {
//            case .success(let success):
//                print(success)
//                student = success
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    }
}

struct StudentProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentProfileScreen()
    }
}
