//
//  MusicTasteScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 19.5.23..
//

import SwiftUI

struct MusicTasteScreen: View {
    enum UserType {
        case student
        case teacher
    }
    
    let userType: UserType
    
    @State private var about = ""
    @State private var eduExp = ""
    
    var body: some View {
        HStack {
            OnboardingSidebar()
            
            Spacer()
            
            SSContentBackground {
                Text("Music taste")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 32)
                
                Text("Spotify")
                    .font(.title3)
                    .padding(.bottom, 8)
                NavigationLink(destination: Text("Link to Spotify account")) {
                    SSSecondaryNavigationButtonText(text: "Link to Spotify account", fullWidth: true)
                        .padding(.bottom, 4)
                }
                
                Text(linkTextForUserType())
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 32)
                
                Text("Upload songs/playlist")
                    .font(.title3)
                    .padding(.bottom, 8)
                NavigationLink(destination: Text("Upload songs/playlist")) {
                    SSSecondaryNavigationButtonText(text: "Upload songs/playlist", fullWidth: true)
                        .padding(.bottom, 32)
                }
                
                Text("Enter music taste manually")
                    .font(.title3)
                    .padding(.bottom, 8)
                NavigationLink(destination: Text("Genres")) {
                    SSSecondaryNavigationButtonText(text: "Select favourite genre(s)", fullWidth: true)
                }
                .padding(.bottom, 32)
                
                Spacer()
                
                NavigationLink(destination: destinationForSelectionView) {
                    SSPrimaryNavigationButtonText(text: "Continue")
                }
            }
            .padding(.horizontal)
            
        }
        .padding()
        .padding(.leading)
    }
    
    private func linkTextForUserType() -> String {
        switch userType {
        case .student:
            return "By linking to Spotify you can upload your favourite music, so we can determine your music taste and link you with the best teacher possible."
        case .teacher:
            return "By linking to Spotify you can upload your favourite music, so we can determine your music taste and link you with the best student possible."
        }
    }
    
    @ViewBuilder
    var destinationForSelectionView: some View {
        switch userType {
        case .student:
            StudentContentView()
        case .teacher:
            TeacherContentView()
        }
    }

}


struct MusicTasteScreen_Previews: PreviewProvider {
    static var previews: some View {
        MusicTasteScreen(userType: .student)
    }
}



