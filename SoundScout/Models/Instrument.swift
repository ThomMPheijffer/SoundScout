//
//  Instrument.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

struct Instruments: Codable {
    let instruments: [Instrument]
}

struct Instrument: Codable {
    let name: String
}
