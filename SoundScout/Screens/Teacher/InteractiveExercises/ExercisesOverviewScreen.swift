//
//  ExercisesOverviewScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import SwiftUI

struct ExercisesOverviewScreen: View {
    let song: Song
    @State var exercises = [Exercise]()
    
    var body: some View {
        List {
            ForEach(exercises, id: \.title) { exercise in
                NavigationLink(destination: detailViewDestionation(exercise: exercise)) {
                    HStack(spacing: 0) {
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
                        }
                        
                        Text(exercise.title)
                            .font(.callout)
                            .padding(.leading, 16)
                            .frame(width: 200, alignment: .leading)
                    }
                }
            }
        }
        .navigationTitle("Exercises")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if let _ = UserDefaults.standard.string(forKey: "teacherID") {
                    NavigationLink(destination: CreateExerciseScreen(song: song)) {
                        Text("Create exercise")
                        //                    SSPrimaryNavigationButtonText(text: "Create exercise")
                    }
                }
            }
        }
        .task {
            let result = await ExercisesService().getExercises(songId: song.id)
            switch result {
            case .success(let data):
                self.exercises = data.exercises
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    @ViewBuilder
    func detailViewDestionation(exercise: Exercise) -> some View {
        if UserDefaults.standard.string(forKey: "studentID") != nil {
            ExerciseDetailScreen(song: song, exercise: exercise)
        } else if UserDefaults.standard.string(forKey: "teacherID") != nil {
            TeacherExerciseDetailScreen(song: song, exercise: exercise)
        } else {
            Text("No student nor teacher signed in")
        }
    }
}
