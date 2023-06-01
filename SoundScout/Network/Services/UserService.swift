//
//  UserService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 01/06/2023.
//

import Foundation

protocol UsersServiceable {
    func login(credentials: LoginCredentials) async -> Result<LoginResponse, RequestError>
}

struct UsersService: HTTPClient, UsersServiceable {
    func login(credentials: LoginCredentials) async -> Result<LoginResponse, RequestError> {
        await sendRequest(endpoint: UserEndpoint.login(credentials: credentials), responseModel: LoginResponse.self)
    }
}
