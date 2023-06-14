//
//  Encodable+Extensions.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 14/06/2023.
//

import Foundation

extension Encodable {
    func stringified() -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let encodedJson = try! encoder.encode(self)
        return String(decoding: encodedJson, as: UTF8.self)
    }
}
