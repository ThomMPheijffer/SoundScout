//
//  TeacherSidebar.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/05/2023.
//

import SwiftUI

struct TeacherSidebar: View {
    @Binding var selection: Panel?
    
    var body: some View {
        List(selection: $selection) {
            NavigationLink(value: Panel.home) {
                Label("Home", systemImage: "house")
            }
            
            NavigationLink(value: Panel.schedule) {
                Label("Schedule", systemImage: "calendar")
            }
            
            NavigationLink(value: Panel.students) {
                Label("My Students", systemImage: "person.3")
            }
            
            NavigationLink(value: Panel.songs) {
                Label("My songs", systemImage: "music.note.list")
            }
            
            NavigationLink(value: Panel.profile) {
                Label("Profile", systemImage: "person")
            }
        }
    }
}
