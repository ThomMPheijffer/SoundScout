//
//  MySongsScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/05/2023.
//

import SwiftUI

struct MySongsScreen: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10, id: \.self) { i in
                    NavigationLink(destination: Text("Thinking out loud")) {
                        HStack(spacing: 0) {
                            Color.green
                                .frame(width: 40, height: 40)
                            
                            Text("Thinking out loud")
                                .font(.callout)
                                .padding(.leading, 16)
                            
                            Text("Ed Sheeran")
                                .font(.callout)
                                .foregroundColor(.secondary)
                                .padding(.leading, 64)
                        }
                    }
                }
            }
            .navigationTitle("My Songs")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Text("Add Songs")) {
                        SSPrimaryNavigationButtonText(text: "Add song")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search songs")
        }
        
    }
}

struct MySongsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MySongsScreen()
    }
}
