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

    var header: [String: String]? {
        switch self {
        case .getSongs:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getSongs:
            return nil
        }
    }
}


