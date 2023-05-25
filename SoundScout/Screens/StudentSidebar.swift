//
//  StudentSidebar.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 24.5.23..
//

import SwiftUI

struct StudentSidebar: View {
    @Binding var selection: StudentPanel?

    var body: some View {
        List(selection: $selection) {
            NavigationLink(value: StudentPanel.home) {
                Label("Home", systemImage: "house")
            }

            NavigationLink(value: StudentPanel.schedule) {
                Label("Schedule", systemImage: "calendar")
            }

            NavigationLink(value: StudentPanel.myTeachers) {
                Label("My Teachers", systemImage: "person.3")
            }
            
            NavigationLink(value: StudentPanel.findTeachers) {
                Label("Find Teachers", systemImage: "magnifyingglass")
            }

            NavigationLink(value: StudentPanel.songs) {
                Label("My songs", systemImage: "music.note.list")
            }

            NavigationLink(value: StudentPanel.profile) {
                Label("Profile", systemImage: "person")
            }
            
            NavigationLink(value: StudentPanel.myMessages) {
                Label("Profile", systemImage: "messages")
            }
        }
        .navigationTitle("SoundScout")
    }
}
