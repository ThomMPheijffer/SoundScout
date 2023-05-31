//
//  InstrumentsService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

protocol InstrumentsServiceable {
    func getAllInstruments() async -> Result<Instruments, RequestError>
    func getInstrumentDetails(id: Int) async -> Result<Instrument, RequestError>
    func postInstrument(instrument: Instrument) async -> Result<Instrument, RequestError>
}

struct InstrumentsService: HTTPClient, InstrumentsServiceable {
    func getAllInstruments() async -> Result<Instruments, RequestError> {
        return await sendRequest(endpoint: InstrumentsEndpoint.getInstruments, responseModel: Instruments.self)
    }
    
    func getInstrumentDetails(id: Int) async -> Result<Instrument, RequestError> {
        return await sendRequest(endpoint: InstrumentsEndpoint.getInstrumentDetails(id: id), responseModel: Instrument.self)
    }
    
    func postInstrument(instrument: Instrument) async -> Result<Instrument, RequestError> {
        return await sendRequest(endpoint: InstrumentsEndpoint.postInstrument(instrument: instrument), responseModel: Instrument.self)
    }
}
