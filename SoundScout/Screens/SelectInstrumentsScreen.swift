//
//  SelectInstruments.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 21.5.23..
//

import SwiftUI

struct SelectInstrumentsScreen: View {
    
    @State var isEnabled = false
    
    var body: some View {
        NavigationStack {
            HStack {
                SSContentBackground {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Search")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 8)
                            
                            TextField("Search instruments", text: .constant(""))
                                .padding(.leading, 4)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(SSColors.blue.opacity(0.3), lineWidth: 1)
                                )
                            
                            Color.gray
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 32)
                                .padding(.horizontal, -32)
                            
                            ForEach(0..<10, id: \.self) { i in
                                Button(action: {isEnabled.toggle()}) {
                                    HStack {
                                        SSCheckbox(isEnabled: $isEnabled)
                                        Text("Piano")
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(SSColors.blue.opacity(0.1))
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(SSColors.blue.opacity(isEnabled ? 1 : 0), lineWidth: 2)
                                        )
                                    .cornerRadius(8)
                                    .padding(.bottom, 16)
                                    
                                }
                            }
                            
                        }
                    }
                }
                .padding(.horizontal)
            }.padding()
                .navigationTitle("Select instruments").navigationBarTitleDisplayMode(.large).toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button { } label: {
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

