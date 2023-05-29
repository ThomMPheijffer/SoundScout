//
//  TeacherRecordExerciseScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 29.5.23..
//

import SwiftUI

struct TeacherRecordExerciseScreen: View {
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Record exercise")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Divider()
                    .padding(.vertical, -80)
                Button(action: {}) {
                    SSPrimaryNavigationButtonText(text: "Upload audio", fullWidth: false)
                }
                .padding(48)
            }
            
            Divider()
                .padding(.horizontal, -32)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Select other resource")
                        .bold()
                        .foregroundColor(SSColors.blue)
                        .padding(.bottom, 32)
                    
                    Color.gray
                        .frame(width: 450, height: 635.07)
                }
                .padding()
                
                Spacer()
                
                Divider()
                    .padding(.vertical, -185)
                
                VStack(alignment: .leading) {
                    Text("Metronome tempo")
                        .font(.title3)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Button(action: {}) {
                            SSSecondaryNavigationButtonText(text: "Select BPM", fullWidth: false)
                        }
                        
                        Text("BPM")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("0:22.55")
                            .font(.title2)
                        
                        HStack {
                            Button(action: {}) {
                                SSSecondaryNavigationButtonText(text: "Play", fullWidth: false)
                            }
                            Button(action: {}) {
                                SSSecondaryNavigationButtonText(text: "Remove", fullWidth: false)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        SSPrimaryNavigationButtonText(text: "Finish exercise", fullWidth: false)
                    }
                }
            }
            
            Spacer()
            
        }
        .padding()
    }
}

struct TeacherRecordExerciseScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeacherRecordExerciseScreen()
    }
}
