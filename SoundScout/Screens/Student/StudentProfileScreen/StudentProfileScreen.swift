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
        Group {
            if student != nil {
                ScrollView {
                    VStack {
                        SSColors.blueInactive
                            .frame(height: 220)
                            .overlay {
                                if let profilePicture = URL(string: student?.profilePicture ?? "") {
                                    AsyncImage(url: profilePicture) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Circle()
                                            .fill(SSColors.blue)
                                            .opacity(0.1)
                                    }
                                    .shadow(radius: 6)
                                    .frame(width: 185, height: 185)
                                    .cornerRadius(92.5)
                                    .clipped()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .offset(y: 110)
                                } else {
                                    Circle()
                                        .fill(SSColors.blue)
                                        .shadow(radius: 6)
                                        .frame(width: 185, height: 185)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .offset(y: 110)
                                }
                            }
                        
                        HStack(spacing: 16) {
                            VStack(alignment: .leading) {
                                Text("\(student?.firstName ?? "") \(student?.lastName ?? "")")
                                    .font(.title2)
                                    .bold()
                                Text("The Hague, Netherlands")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: Text("Lessons")) {
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
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(student?.about ?? "")
                                .foregroundColor(.secondary)
                        }
                        .padding([.horizontal, .top])
                        
                        SSContentBackground(padding: 16) {
                            Text("Interests")
                                .font(.title2)
                                .bold()
                                .padding(.bottom)
                            HStack(spacing: 64) {
                                ForEach(student!.instruments) { instrument in
                                    Text(instrument.name)
                                        .bold()
                                }
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
                            Text(student?.priorExperience ?? "")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        
                        Button("Logout") {
                            UserDefaults.standard.set(nil, forKey: "studentID")
                            UserDefaults.standard.set(nil, forKey: "studentUserID")
                            UserDefaults.standard.set(nil, forKey: "teacherID")
                            UserDefaults.standard.set(nil, forKey: "teacherUserID")
                            
//                            Spotify().de
                            
                            let vc = UIHostingController(rootView: SignUpScreen().environmentObject(navigationManager).environmentObject(spotify))
                            replaceKeyWindow(with: vc)
                        }
                        
                    }
                }
                .ignoresSafeArea(edges: .top)
            } else {
                ProgressView()
            }
        }
        .task {
            guard let studentID = UserDefaults.standard.string(forKey: "studentUserID") else { return }
            print(studentID)
            let result = await StudentsService().getStudentDetails(id: studentID)
            switch result {
            case .success(let success):
                print(success)
                student = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

struct StudentProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentProfileScreen()
    }
}
