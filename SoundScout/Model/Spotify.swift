//
//  Spotify.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 24/05/2023.
//

import Foundation
import Combine
import UIKit
import SwiftUI
import KeychainAccess
import SpotifyWebAPI

final class Spotify: ObservableObject {
    private static let clientId: String = "48008d47e6494a37a16aaf8d78e00c8a"
    private static let clientSecret: String = "679e2477231b4f77a81d71871a22746f"
    
    let authorizationManagerKey = "authorizationManager"
    let loginCallbackURL = URL(string: "spotify-api-example-app://login-callback")!
    
    var authorizationState = String.randomURLSafe(length: 128)
    
    @Published var isAuthorized = false
    @Published var isRetrievingTokens = false
    @Published var currentUser: SpotifyUser? = nil
    
    let keychain = Keychain(service: "com.thomPheijffer.SoundScout")
    
    let api = SpotifyAPI(authorizationManager: AuthorizationCodeFlowManager(clientId: Spotify.clientId, clientSecret: Spotify.clientSecret))
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        
        self.api.apiRequestLogger.logLevel = .trace
        self.api.logger.logLevel = .trace
        
        self.api.authorizationManagerDidChange
            .receive(on: RunLoop.main)
            .sink(receiveValue: authorizationManagerDidChange)
            .store(in: &cancellables)
        
        self.api.authorizationManagerDidDeauthorize
            .receive(on: RunLoop.main)
            .sink(receiveValue: authorizationManagerDidDeauthorize)
            .store(in: &cancellables)
        
        if let authManagerData = keychain[data: self.authorizationManagerKey] {
            
            do {
                let authorizationManager = try JSONDecoder().decode(AuthorizationCodeFlowManager.self, from: authManagerData)
                self.api.authorizationManager = authorizationManager
            } catch {
                print("could not decode authorizationManager from data:\n\(error)")
            }
        }
        else {
            print("did NOT find authorization information in keychain")
        }
        
    }
    
    func authorize() {
        let url = self.api.authorizationManager.makeAuthorizationURL(
            redirectURI: self.loginCallbackURL,
            showDialog: true,
            state: self.authorizationState,
            scopes: [
                .userReadPlaybackState,
                .userModifyPlaybackState,
                .userLibraryRead,
            ]
        )!
        
        UIApplication.shared.open(url)
        
    }
    
    func authorizationManagerDidChange() {
        self.isAuthorized = self.api.authorizationManager.isAuthorized()
        
        print("Spotify.authorizationManagerDidChange: isAuthorized:", self.isAuthorized)
        
        self.retrieveCurrentUser()
        
        do {
            let authManagerData = try JSONEncoder().encode(self.api.authorizationManager)
            self.keychain[data: self.authorizationManagerKey] = authManagerData
            print("did save authorization manager to keychain")
            
        } catch {
            print("couldn't encode authorizationManager for storage " + "in keychain:\n\(error)")
        }
        
    }
    
    func authorizationManagerDidDeauthorize() {
        self.isAuthorized = false
        
        self.currentUser = nil
        
        do {
            try self.keychain.remove(self.authorizationManagerKey)
            print("did remove authorization manager from keychain")
            
        } catch {
            print(
                "couldn't remove authorization manager " +
                "from keychain: \(error)"
            )
        }
    }
    
    func retrieveCurrentUser(onlyIfNil: Bool = true) {
        
        if onlyIfNil && self.currentUser != nil {
            return
        }
        
        guard self.isAuthorized else { return }
        
        self.api.currentUserProfile()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("couldn't retrieve current user: \(error)")
                    }
                },
                receiveValue: { user in
                    self.currentUser = user
                }
            )
            .store(in: &cancellables)
        
    }
    
}
