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
    case postDocument(songId: String, documentMultipartForm: MultipartRequest)
}

extension SongEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getSongsForTeacher(let teacherId):
            return "/songs/user/\(teacherId)"
        case .postSong:
            return "/songs"
        case .postDocument(let songId, _):
            return "/songs/\(songId)/add-document"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getSongsForTeacher:
            return .get
        case .postSong, .postDocument:
            return .post
    
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getSongsForTeacher, .postDocument:
            return nil
        case .postSong(let song):
            return song
        }
    }
    
    var multipartRequest: MultipartRequest? {
        switch self {
        case .getSongsForTeacher, .postSong:
            return nil
        case .postDocument(_, let document):
            return document
        }
    }
}


