//
//  StudentHomeScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct StudentHomeScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @State var lessons: [Lesson] = []
    
    var body: some View {
        VStack(spacing: 32) {
            SSContentBackground(padding: 32) {
                SSContentHeader(text: "Schedule for next week", buttonText: "Show complete schedule") {
                    navigationManager.studentSelection = .schedule
                }
                .padding(.bottom, 16)
                
                HStack(spacing: 0) {
                    ForEach(7..<14) { i in
                        Color.black.opacity(0.1)
                            .overlay(
                                VStack(spacing: 0) {
                                    Text("\(i)")
                                        .padding()
                                    
                                    if i != 10 {
                                        Spacer()
                                    } else {
                                        VStack(alignment: .leading) {
                                            Text("Guitar lesson")
                                                .font(.caption2)
                                                .padding(8)
                                            Text("14:00")
                                                .font(.system(size: 10))
                                                .foregroundColor(.secondary)
                                                .padding(.leading, 8)
                                            
                                            Spacer()
                                            
                                            HStack {
                                                Circle()
                                                    .fill(SSColors.blue)
                                                    .frame(width: 16, height: 16)
                                                
                                                Text("Walter")
                                                    .font(.system(size: 10))
                                            }
                                            .padding(8)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(uiColor: .init(red: 223/253, green:236/253, blue: 253/253, alpha: 1)))
                                        .padding([.horizontal, .bottom])
                                        .cornerRadius(8)
                                        .clipped()
                                    }
                                }
                            )
                        
                        if i != 13 {
                            Divider()
                        }
                    }
                }
                .frame(maxHeight: 140)
                .cornerRadius(8)
            }
            
            SSContentBackground(padding: 32) {
                SSContentHeader(text: "My recent lessons", buttonText: "All lessons") {
                    navigationManager.studentSelection = .myLessons
                }
                .padding(.bottom, 16)
                
                Divider()
                    .padding(.horizontal, -32)
                
                
                ForEach(0..<lessons.count, id: \.self) { i in
                    VStack {
                        NavigationLink(destination: StudentLessonDetailsScreen(lesson: lessons[i])) {
                            HStack {
                                Text(lessons[i].lessonDate, style: .date)
                                
                                if let profilePicture = URL(string: lessons[i].profilePicture ?? "") {
                                    AsyncImage(url: profilePicture) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Circle()
                                            .fill(SSColors.blue)
                                            .opacity(0.1)
                                    }
                                    
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(15)
                                    .clipped()
                                }
                                
                                Spacer()
                                HStack {
                                    Text("Show details")
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(SSColors.blue)
                                .bold()
                            }
                            .font(.callout)
                            
                        }
                    }
                    .padding(i == (lessons.count - 1) ? .top : .vertical)
                    
                    if i != (lessons.count - 1) {
                        Divider()
                            .padding(.horizontal, -32)
                    }
                }
                
                
            }
            .task {
                let result = await LessonsService().getLessons(userId: UserDefaults.standard.string(forKey: "studentID")!)

                switch result {
                case .success(let data):
                    if data.lessons.count > 4 {
                        self.lessons = Array(data.lessons.prefix(upTo: 4))
                    } else {
                        self.lessons = data.lessons
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Home")
    }
}

