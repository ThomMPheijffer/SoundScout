//
//  TeacherProfileScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 25/05/2023.
//

import SwiftUI

struct TeacherProfileScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var spotify: Spotify
    
    @State var teacher: Teacher? = nil
    let canConnect: Bool
    
    init(loadedTeacher: Teacher? = nil, canConnect: Bool = false) {
        self.canConnect = canConnect
        if loadedTeacher != nil {
            self._teacher = State.init(initialValue: loadedTeacher)
        }
    }
    
    var body: some View {
        Group {
            if teacher != nil {
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
                                Text("\(teacher!.firstName) \(teacher!.lastName)")
                                    .font(.title2)
                                    .bold()
                                Text("The Hague, Netherlands")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("$100")
                                    .font(.title2)
                                    .bold()
                                Text("lesson")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            if canConnect {
                                Button(action: {
                                    Task {
                                        guard let teacherId = teacher?.id else { return }
                                        guard let studentId = UserDefaults.standard.string(forKey: "studentID") else { return }
                                        let result = await StudentsService().addTeacherToStudent(studentId: studentId, body: .init(teacherId: teacherId))
                                        
                                        switch result {
                                        case .success(let success):
                                            print(success)
                                            print("Succesfully connected")
                                        case .failure(let failure):
                                            print(failure)
                                        }
                                    }
                                }) {
                                    SSPrimaryNavigationButtonText(text: "Add to my Teachers", fullWidth: false)
                                }
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
                            Text(teacher!.about)
                                .foregroundColor(.secondary)
                        }
                        .padding([.horizontal, .top])
                        
                        SSContentBackground(padding: 16) {
                            Text("Skills")
                                .font(.title2)
                                .bold()
                                .padding(.bottom)
                            HStack(spacing: 64) {
                                ForEach(teacher!.instruments) { instrument in
                                    Text(instrument.name)
                                        .bold()
                                }
                                Spacer()
                            }
                            .foregroundColor(.secondary)
                        }
                        .padding([.horizontal, .top])
                        
                        SSContentBackground(padding: 16) {
                            Text("Experience")
                                .font(.title2)
                                .bold()
                                .padding(.bottom)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(teacher!.priorExperience)
                                .foregroundColor(.secondary)
                        }
                        .padding([.horizontal, .top])
                        
                        SSContentBackground(padding: 16) {
                            Text("Showcase")
                                .font(.title2)
                                .bold()
                                .padding(.bottom)
                            HStack {
                                Color.black.opacity(0.3)
                                    .frame(height: 240)
                                    .cornerRadius(8)
                                
                                Color.black.opacity(0.3)
                                    .frame(height: 240)
                                    .cornerRadius(8)
                            }
                        }
                        .padding([.horizontal, .top])
                        
                        SSContentBackground(padding: 16) {
                            HStack(alignment: .bottom) {
                                Text("Reviews")
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                                
                                HStack(spacing: 2) {
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star")
                                }
                                .foregroundColor(.yellow)
                                .font(.title2)
                                .bold()
                                
                                Text("4.2 out 5")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.secondary)
                            }
                            
                            Divider()
                                .padding(.vertical)
                                .padding(.horizontal, -16)
                            
                            ForEach(0..<2, id: \.self) { i in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("Kevin")
                                            .font(.headline)
                                            .bold()
                                        
                                        HStack(spacing: 0) {
                                            Image(systemName: "star.fill")
                                            Image(systemName: "star.fill")
                                            Image(systemName: "star.fill")
                                            Image(systemName: "star.fill")
                                            Image(systemName: "star")
                                        }
                                        .foregroundColor(.yellow)
                                        .font(.headline)
                                        .bold()
                                    }
                                    Text("Great first lesson. I am looking forward to the next")
                                    Text("April 11, 2023")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                    
                                    if i != 1 {
                                        Divider()
                                            .padding(.vertical)
                                            .padding(.horizontal, -16)
                                    }
                                }
                            }
                            
                        }
                        .padding()
                        
                        Button("Logout") {
                            UserDefaults.standard.set(nil, forKey: "studentID")
                            UserDefaults.standard.set(nil, forKey: "studentUserID")
                            UserDefaults.standard.set(nil, forKey: "teacherID")
                            UserDefaults.standard.set(nil, forKey: "teacherUserID")
                            
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
            guard teacher == nil else { return }
            guard let teacherID = UserDefaults.standard.string(forKey: "teacherUserID") else { return }
            let result = await TeachersService().getTeacherDetails(id: teacherID)
            switch result {
            case .success(let success):
                print(success)
                teacher = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

struct TeacherProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeacherProfileScreen()
    }
}
