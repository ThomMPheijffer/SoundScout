//
//  Endpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: (any Codable)? { get }
    var multipartRequest: MultipartRequest? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api-ztqk.onrender.com"
    }
    
    var header: [String: String]? {
        return [
            "Content-Type": "application/json;charset=utf-8"
        ]
    }
    
    var multipartRequest: MultipartRequest? {
        return nil
    }
}
