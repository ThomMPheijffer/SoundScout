//
//  AddSongScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 22/05/2023.
//

import SwiftUI

struct AddSongScreen: View {
    @State var showPopover = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SSTextField(title: "Song name", text: .constant(""))
                .padding(.bottom, 32)
            
            SSTextField(title: "Artist", text: .constant(""))
                .padding(.bottom, 32)
            
            Text("Cover art")
                .padding(.bottom)
            Button(action: {}) {
                SSSecondaryNavigationButtonText(text: "Upload cover art")
            }
            .padding(.bottom, 32)
            
            SSTextField(title: "Teacher notes", text: .constant(""), axis: .horizontal)
                .padding(.bottom, 32)
            
            Text("Interactive exercise")
                .padding(.bottom)
            NavigationLink(destination: Text("Create interactive exercise")) {
                SSSecondaryNavigationButtonText(text: "Create interactive exercise")
            }
            .padding(.bottom, 32)
            
            NavigationLink(destination: TeacherSongDetailsScreen()) {
                SSPrimaryNavigationButtonText(text: "Create song")
            }
            .padding(.bottom, 128)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Add song")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showPopover = true }) {
                    SSPrimaryNavigationButtonText(text: "Add song via Spotify")
                }
            }
        }
        .sheet(isPresented: $showPopover) {
            SearchSongScreen()
        }
    }
}

struct AddSongScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddSongScreen()
    }
}
