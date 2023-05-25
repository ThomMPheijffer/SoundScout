//
//  StudentLessonsScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct StudentLessonsScreen: View {
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
        VStack(spacing: 32) {
        
            VStack(alignment: .leading) {
                Text("January 2023").font(.headline).bold()
                
                SSContentBackground(padding: 32) {
                    
                    ForEach(0..<datesJanuary.count, id: \.self) { i in
                        
                        VStack {
                            HStack {
                                Text(datesJanuary[i])
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
            
            VStack(alignment: .leading) {
                
                Text("February 2023").font(.headline).bold()
                SSContentBackground(padding: 32) {
                    
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
        .navigationTitle("Lessons")
    }
}

struct StudentLessonsScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentLessonsScreen()
    }
}
