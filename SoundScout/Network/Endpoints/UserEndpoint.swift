//
//  UserEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 01/06/2023.
//

import Foundation

enum UserEndpoint {
    case login(credentials: LoginCredentials)
}

extension UserEndpoint: Endpoint {
    var path: String {
        switch self {
        case .login:
            return "/users/login"
        }
    }

    var method: RequestMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var header: [String: String]? {
        switch self {
        case .login:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: LoginCredentials? {
        switch self {
        case .login(let credentials):
            return credentials
        }
    }
}

