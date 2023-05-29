//
//  StudentExercisesScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 28.5.23..
//

import SwiftUI

struct StudentExercisesScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let exercises = [
        "Intro",
        "Pre chorus",
        "Chorus",
        "Outro",
        "Whole song",
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Exercises")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 32)
            
            ForEach(0..<exercises.count, id: \.self) { i in
                
                VStack {
                    HStack {
                        Color.green
                            .frame(width: 40, height: 40)
                        Text(exercises[i])
                        
                        Spacer()
                        
                        Text("Ed Sheeran")
                            .foregroundColor(.secondary)
                        
                        NavigationLink(destination: StudentSongDetailsScreen()) {
                            HStack {
                                Text("Practise")
                                Image(systemName: "chevron.right")
                            }
                            .font(.callout)
                            .bold()
                        }
                    }
                    .font(.callout)
                    
                }
                .padding(i == 4 ? .top : .vertical, 8)
                
                if i != 4 {
                    Divider()
                        .padding(.horizontal, -32)
                }
            }
            Spacer()
        }
        .padding(32)
    }
}

struct StudentExercisesScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentExercisesScreen()
    }
}
