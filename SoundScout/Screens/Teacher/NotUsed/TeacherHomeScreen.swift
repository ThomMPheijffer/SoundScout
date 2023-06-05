//
//  TeacherHomeScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct TeacherHomeScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let dates = [
        "3rd January",
        "21st January",
        "23rd January",
        "28th January",
    ]
    
    var body: some View {
        VStack(spacing: 32) {
            SSContentBackground(padding: 32) {
                SSContentHeader(text: "Schedule", buttonText: "Show complete schedule") {
//                    navigationManager.teacherSelection = .schedule
                }
            }
            
            HStack(spacing: 32) {
                SSContentBackground(padding: 32) {
                    SSContentHeader(text: "My songs", buttonText: "All songs") {
                        navigationManager.teacherSelection = .songs
                    }
                    .padding(.bottom, 16)
                    
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
                                
                                Spacer()
                                
                                NavigationLink(destination: StudentSongDetailsScreen()) {
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
                    SSContentHeader(text: "My lessons", buttonText: "All lessons") {
                        navigationManager.teacherSelection = .profile
                    }
                    .padding(.bottom, 16)
                    
                    Divider()
                        .padding(.horizontal, -32)
                    
                    
                    ForEach(0..<dates.count, id: \.self) { i in
                        
                        
                        VStack {
                            HStack {
                                Text(dates[i])
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
                        .padding(i == 3 ? .top : .vertical)
                        
                        if i != 3 {
                            Divider()
                                .padding(.horizontal, -32)
                        }
                    }
                    
                    
                }
            }
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Home")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: TeacherMessagesScreen()) {
                    Image(systemName: "bell.badge").font(.title2).foregroundColor(Color.black)
                }
            }
        }
    }
}


