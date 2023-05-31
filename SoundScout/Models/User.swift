//
//  User.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

struct User: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
}
