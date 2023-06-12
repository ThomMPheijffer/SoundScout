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

struct Song: Codable {
//    let id: String
    let teacherId: String
    let title: String
    let artist: String
    let teacherNotes: String
    let coverUrl: String?
}

struct PostSong: Codable {
    let teacherId: String
    let title: String
    let artist: String
    let teacherNotes: String
    let coverUrl: String?
}
