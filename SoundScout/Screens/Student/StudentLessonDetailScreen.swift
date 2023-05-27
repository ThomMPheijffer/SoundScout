//
//  LessonDetailScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct StudentLessonDetailsScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let dates = [
        "3rd January",
        "21st January",
        "23rd January",
        "28th January",
    ]
    let addResources = [
        "Music stave",
        "Chords overview",
    ]
    
    var body: some View {
        VStack(spacing: 32) {
            SSContentBackground(padding: 32) {
                Text( "Lesson notes").padding(.bottom, 8)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies felis eu enim consequat, nec luctus enim posuere. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque hendrerit nunc nunc, at cursus tortor interdum at. Ut eget vehicula lacus. Nam non fermentum nulla.")
            }
            
            SSContentBackground(padding: 32) {
                Text("Songs")
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
                            
                            SSContentHeader(text: "", buttonText: "Show details") {
                                navigationManager.studentSelection =  .songs
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
                // Should be aligned better
                VStack(alignment: .leading){
                    Text("Aditional resources")
                    
                    ForEach(0..<addResources.count, id: \.self) { i in
                        VStack {
                            HStack {
                                Image(systemName: "doc")
                                Text(addResources[i])
                                
                            }
                            .font(.callout)
                        }
                    }
                }
            }            
        }
        .padding()
        .navigationTitle("Lesson - January")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: StudentMessagesScreen()) {
                    Image(systemName: "bell.badge").font(.title2).foregroundColor(Color.black)
                }
            }
        }
    }
}



