//
//  InstrumentsEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

enum InstrumentsEndpoint {
    case allInstruments
    case instrumentDetail(id: Int)
    case addInstrument(instrument: Instrument)
}

extension InstrumentsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .allInstruments:
            return "/instruments"
        case .instrumentDetail(let id):
            return "/instruments/\(id)"
        case .addInstrument:
            return "/instruments"
        }
    }

    var method: RequestMethod {
        switch self {
        case .allInstruments, .instrumentDetail:
            return .get
        case .addInstrument:
            return .post
        }
    }

    var header: [String: String]? {
        switch self {
        case .allInstruments, .instrumentDetail, .addInstrument:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: Instrument? {
        switch self {
        case .allInstruments, .instrumentDetail:
            return nil
        case .addInstrument(let instrument):
            return instrument
        }
    }
}

