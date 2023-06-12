//
//  SongEndpoint.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 5.6.23..
//

import Foundation

enum SongEndpoint {
    case getSongs
    case postSong(song: PostSong)
}

extension SongEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getSongs, .postSong:
            return "/songs"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getSongs:
            return .get
        case .postSong:
            return .post
    
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getSongs:
            return nil
        case .postSong(let song):
            return song
        }
    }
}


