//
//  HTTPClient.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: any Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: any Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try! encoder.encode(body)
            print(String(decoding: request.httpBody!, as: UTF8.self))
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            print(response)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                print(responseModel)
                print(data)
                print(String(decoding: data, as: UTF8.self))
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedResponse = try! decoder.decode(responseModel, from: data)
//                guard let decodedResponse = try? decoder.decode(responseModel, from: data) else { return .failure(.decode) }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
