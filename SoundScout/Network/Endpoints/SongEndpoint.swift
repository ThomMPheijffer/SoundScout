//
//  SongEndpoint.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 5.6.23..
//

import Foundation

enum SongEndpoint {
    case getSongs
}

extension SongEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getSongs:
            return "/songs"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getSongs:
            return .get
    
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getSongs:
            return nil
        }
    }
}


