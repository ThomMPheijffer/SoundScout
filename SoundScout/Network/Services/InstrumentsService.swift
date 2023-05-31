//
//  InstrumentsService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

protocol InstrumentsServiceable {
    func getAllInstruments() async -> Result<Instruments, RequestError>
    func getInstrumentDetail(id: Int) async -> Result<Instrument, RequestError>
    func postInstrument(instrument: Instrument) async -> Result<Instrument, RequestError>
}

struct InstrumentsService: HTTPClient, InstrumentsServiceable {
    func getAllInstruments() async -> Result<Instruments, RequestError> {
        return await sendRequest(endpoint: InstrumentsEndpoint.allInstruments, responseModel: Instruments.self)
    }
    
    func getInstrumentDetail(id: Int) async -> Result<Instrument, RequestError> {
        return await sendRequest(endpoint: InstrumentsEndpoint.instrumentDetail(id: id), responseModel: Instrument.self)
    }
    
    func postInstrument(instrument: Instrument) async -> Result<Instrument, RequestError> {
        return await sendRequest(endpoint: InstrumentsEndpoint.addInstrument(instrument: instrument), responseModel: Instrument.self)
    }
}
