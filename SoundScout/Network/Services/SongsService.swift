//
//  SongsService.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 5.6.23..
//

import Foundation

protocol SongsServiceable {
    func getAllSongs() async -> Result<Songs, RequestError>
    func postSong(song: PostSong) async -> Result<Song, RequestError>
}

struct SongsService: HTTPClient, SongsServiceable {
    func getAllSongs() async -> Result<Songs, RequestError> {
        return await sendRequest(endpoint: SongEndpoint.getSongs, responseModel: Songs.self)
    }
    
    func postSong(song: PostSong) async -> Result<Song, RequestError> {
        return await sendRequest(endpoint: SongEndpoint.postSong(song: song), responseModel: Song.self)
    }
    
}
