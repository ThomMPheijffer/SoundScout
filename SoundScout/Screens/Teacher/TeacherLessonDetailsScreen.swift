//
//  TeacherLessonDetailsScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 29.5.23..
//

import SwiftUI

struct TeacherLessonDetailsScreen: View {
    let lesson: Lesson
    
    let addResources = [
        "Music stave",
        "Chords overview",
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                SSContentBackground(padding: 32) {
                    Text( "Lesson notes")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                    Text(lesson.lessonNotes)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                SSContentBackground(padding: 32) {
                    Text("Songs")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                    
                    Divider()
                        .padding(.horizontal, -32)
                    
                    ForEach(0..<4, id: \.self) { i in
                        
                        VStack {
                            HStack {
                                Color.green
                                    .frame(width: 40, height: 40)
                                Text("Thinking out loud")
                                
                                Spacer()
                                
                                Text("Ed Sheeran")
                                    .foregroundColor(.secondary)
                                
                                NavigationLink(destination: TeacherSongDetailsScreen()) {
                                    HStack {
                                        Text("Show material")
                                        Image(systemName: "chevron.right")
                                    }
                                    .font(.callout)
                                    .bold()
                                }
                            }
                            .font(.callout)
                            
                        }
                        .padding(i == 3 ? .top : .vertical, 8)
                        
                        if i != 3 {
                            Divider()
                                .padding(.horizontal, -32)
                        }
                    }
                }
                
                SSContentBackground(padding: 32) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Additional resources")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 8)
                            ForEach(0..<addResources.count, id: \.self) { i in
                                HStack {
                                    Image(systemName: "doc")
                                    Text(addResources[i])
                                }
                                .font(.callout)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Lesson - January")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: Text("Teacher message screen")) {
                    Image(systemName: "bell.badge").font(.title2).foregroundColor(Color.black)
                }
            }
        }
    }
}




