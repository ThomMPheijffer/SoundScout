//
//  TeacherSidebar.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/05/2023.
//

import SwiftUI

struct TeacherSidebar: View {
    @Binding var selection: TeacherPanel?
    
    var body: some View {
        List(selection: $selection) {
//            NavigationLink(value: TeacherPanel.home) {
//                Label("Home", systemImage: "house")
//            }
//
//            NavigationLink(value: TeacherPanel.schedule) {
//                Label("Schedule", systemImage: "calendar")
//            }
            
            NavigationLink(value: TeacherPanel.students) {
                Label("My Students", systemImage: "person.3")
            }
            
            NavigationLink(value: TeacherPanel.songs) {
                Label("My songs", systemImage: "music.note.list")
            }
            
            NavigationLink(value: TeacherPanel.profile) {
                Label("Profile", systemImage: "person")
            }
            
//            NavigationLink(value: TeacherPanel.myMessages) {
//                Label("Messages", systemImage: "message")
//            }
        }
        .navigationTitle("SoundScout")
    }
}
