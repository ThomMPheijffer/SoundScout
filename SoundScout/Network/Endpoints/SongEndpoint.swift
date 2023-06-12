//
//  SongEndpoint.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 5.6.23..
//

import Foundation

enum SongEndpoint {
    case getSongsForTeacher(teacherId: String)
    case postSong(song: PostSong)
}

extension SongEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getSongsForTeacher(let teacherId):
            return "/songs/user/\(teacherId)"
        case .postSong:
            return "/songs"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getSongsForTeacher:
            return .get
        case .postSong:
            return .post
    
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getSongsForTeacher:
            return nil
        case .postSong(let song):
            return song
        }
    }
}


