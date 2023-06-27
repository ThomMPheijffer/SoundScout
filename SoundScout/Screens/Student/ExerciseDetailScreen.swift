//
//  ExerciseDetailScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import SwiftUI
import Charts

struct ExerciseDetailScreen: View {
    let song: Song
    let exercise: Exercise
    
    @State var practises = [ExercisePractise]()
    
    var body: some View {
        HStack(spacing: 0) {
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
                            
                            NavigationLink(destination: RecordExercisePractiseScreen(song: song, exercise: exercise)) {
                                SSPrimaryNavigationButtonText(text: "Practise", fullWidth: false)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 32)
                    
                    Divider()
                        .padding(.trailing, -16)
                        .padding(.bottom, 32)
                    
                    SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
                        Text("History")
                            .font(.title2)
                            .bold()
                            .padding(.top, 32)
                            .padding(.bottom)
                        
                        Divider()
                            .padding(.horizontal, -32)
                        
                        if practises.count > 0 {
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
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(practises[i].tempo) bpm - \(practises[i].grade)")
                                        Text(practises[i].date, style: .date)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: PractiseDetailScreen(exercise: exercise, practise: practises[i])) {
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
                        } else {
                            Text("No practises yet")
                        }
                    }
                    
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Grades")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                chart
                    .frame(maxHeight: 200)
                    .padding(.bottom, 32)
                
                Text("Practise sessions")
                    .font(.title2)
                    .bold()
                
                practiseCountChart
                    .frame(maxHeight: 200)
                
                Spacer()
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 4)
        }
        .navigationTitle(exercise.title)
        .navigationBarTitleDisplayMode(.large)
        .task {
            guard let studentId = UserDefaults.standard.string(forKey: "studentID") else { return }
            let result = await ExercisePractisesService().getExercisePractises(exerciseId: exercise.id, studentId: studentId)
            
            switch result {
            case .success(let data):
                print(data)
                self.practises = data.exercisePractises.filter { $0.feedback != nil }.sorted { $0.date > $1.date }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    var chart: some View {
        Chart {
            ForEach(convertExercisesToChartData(exercises: practises), id: \.self) { data in
                BarMark(
                    x: .value("Date", data.date),
                    y: .value("BPM", data.bpm)
                )
                .foregroundStyle(data.grade <= 4 ? Color.red : (data.grade < 7 ? Color.yellow : Color.green))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .annotation {
                    Text(data.grade != 0 ? "\(data.grade)" : "")
                }
            }
        }
    }
    
    var practiseCountChart: some View {
        Chart {
            ForEach(convertExercisesToChartDataForPractises(exercises: practises), id: \.self) { data in
                BarMark(
                    x: .value("Date", data.date),
                    y: .value("Practise count", data.practiseCount)
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .annotation {
                    Text(data.practiseCount != 0 ? "\(data.practiseCount)" : "")
                }
            }
        }
    }
}
