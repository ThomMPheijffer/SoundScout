//
//  ExerciseDetailScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import SwiftUI

struct ExerciseDetailScreen: View {
    let song: Song
    let exercise: Exercise
    
    @State var practises = [Exercise]()
    
    var body: some View {
        //        HStack(spacing: 0) {
        ScrollView {
            VStack {
                HStack(spacing: 32) {
                    if let coverUrl = URL(string: song.coverUrl ?? "") {
                        AsyncImage(url: coverUrl) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        }
                        .frame(width: 220, height: 220)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    } else {
                        Color.green
                            .frame(width: 220, height: 220)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(song.title)
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 8)
                        Text(song.artist)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        NavigationLink(destination: ExercisesOverviewScreen(song: song)) {
                            SSPrimaryNavigationButtonText(text: "Practise", fullWidth: false)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 64)
                
                Divider()
                    .padding(.trailing, -16)
                    .padding(.bottom, 64)
                
                SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
                    Text("History")
                        .font(.title2)
                        .bold()
                        .padding(.top, 32)
                    
                    Divider()
                        .padding(.horizontal, -32)
                    
                    ForEach(0..<practises.count, id: \.self) { i in
                        HStack {
                            if let coverUrl = URL(string: song.coverUrl ?? "") {
                                AsyncImage(url: coverUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.purple.opacity(0.1)
                                }
                                .frame(width: 40, height: 40)
                                .cornerRadius(4)
                                .shadow(radius: 2)
                            } else {
                                Color.green
                                    .frame(width: 40, height: 40)
                            }
                            
                            //                                VStack(alignment: .leading) {
                            //                                    Text(practises[i].title)
                            //                                    Text(practises[i].artist)
                            //                                        .foregroundColor(.secondary)
                            //                                }
                            
                            Spacer()
                            
                            NavigationLink(destination: Text("Practise details")) {
                                HStack {
                                    Text("Details")
                                    Image(systemName: "chevron.right")
                                }
                                .font(.callout)
                                .bold()
                            }
                        }
                        .font(.callout)
                        .padding(.vertical)
                        
                        if i != (practises.count - 1) {
                            Divider()
                                .padding(.horizontal, -32)
                        }
                    }
                }
                
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        
        //            Divider()
        //
        //            VStack {
        //                Text("Progress")
        //
        //                Text("Chart")
        //
        //                Spacer()
        //            }
        //            .frame(width: UIScreen.main.bounds.width / 4)
        //        }
        .navigationTitle(exercise.title)
        .navigationBarTitleDisplayMode(.large)
    }
}
