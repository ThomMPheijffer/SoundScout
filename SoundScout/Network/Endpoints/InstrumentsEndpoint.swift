//
//  InstrumentsEndpoint.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

enum InstrumentsEndpoint {
    case getInstruments
    case getInstrumentDetails(id: Int)
    case postInstrument(instrument: Instrument)
}

extension InstrumentsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getInstruments:
            return "/instruments"
        case .getInstrumentDetails(let id):
            return "/instruments/\(id)"
        case .postInstrument:
            return "/instruments"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getInstruments, .getInstrumentDetails:
            return .get
        case .postInstrument:
            return .post
        }
    }
    
    var body: (any Codable)? {
        switch self {
        case .getInstruments, .getInstrumentDetails:
            return nil
        case .postInstrument(let instrument):
            return instrument
        }
    }
}

