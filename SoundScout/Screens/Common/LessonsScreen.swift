//
//  StudentLessonsScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct LessonsScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let student: Student?
    let teacher: Teacher?
    
    let datesJanuary = [
        "3rd January",
        "21st January",
        "23rd January",
        "28th January",
    ]
    let datesFebruary = [
        "5th February",
        "12th February",
        "22nd February",
    ]
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("January 2023").font(.headline).bold()
                
                SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
                    
                    ForEach(0..<datesJanuary.count, id: \.self) { i in
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text(datesJanuary[i])
                                Spacer()
                                
                                NavigationLink(destination: destinationForSelectionView) {
                                    HStack {
                                        Text("Show details")
                                        Image(systemName: "chevron.right")
                                    }
                                    .font(.callout)
                                    .bold()
                                }
                                
                            }
                            .padding(.vertical)
                            
                            if i != (datesJanuary.count - 1) {
                                Divider()
                                    .padding(.horizontal, -32)
                            }
                        }
                        
                        
                    }
                }
                .padding(.bottom, 32)
                
                VStack(alignment: .leading) {
                    Text("February 2023").font(.headline).bold()
                    
                    SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
                        
                        ForEach(0..<datesFebruary.count, id: \.self) { i in
                            
                            VStack {
                                HStack {
                                    Text(datesFebruary[i])
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
                            .padding(.vertical)
                            
                            if i != (datesFebruary.count - 1) {
                                Divider()
                                    .padding(.horizontal, -32)
                            }
                        }
                        
                        
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Lessons")
            .toolbar {
                if student != nil {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CreateLessonScreen(studentId: student!.id)) {
                            SSPrimaryNavigationButtonText(text: "Create lesson")
                        }
                    }
                }
            }
    }
    
    @ViewBuilder
    var destinationForSelectionView: some View {
        if teacher != nil {
            StudentLessonDetailsScreen()
        } else if student != nil {
            TeacherLessonDetailsScreen()
        } else {
            Text("No user type passed through")
        }
    }
}



struct LessonsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LessonsScreen(student: nil, teacher: nil)
    }
}
