//
//  SelectInstruments.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 21.5.23..
//

import SwiftUI

struct SelectInstrumentsScreen: View {
    
    var body: some View {
        
        NavigationStack {
            HStack {
                
                
                SSContentBackground {
                    ScrollView {
                        VStack{
                            ForEach(0..<10, id: \.self) { i in
                                HStack {
                                    SSColors.blue.frame(width: 16, height: 16)
                                    Text("Piano")
                                    Spacer()
                                }.padding().background(SSColors.blue.opacity(0.3)).cornerRadius(8)
                            }
                            
                        }
                        
                    }
                }.padding(.horizontal)
            }.padding()
                .navigationTitle("Select instruments").navigationBarTitleDisplayMode(.large).toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button {
                        
                        } label: {
                            SSPrimaryNavigationButtonText(text: "Done")
                        }

                    }
                }
            
        }
    }
}
struct SelectInstrumentsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectInstrumentsScreen()
    }
}

