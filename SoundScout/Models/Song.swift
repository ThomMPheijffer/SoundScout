//
//  Song.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 5.6.23..
//

import Foundation

struct Songs: Codable {
    let songs: [Song]
}

struct Song: Codable, Identifiable {
    let id: String
    let teacherId: String
    let title: String
    let artist: String
    let teacherNotes: String
}

