//
//  SongsService.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 5.6.23..
//

import Foundation

protocol SongsServiceable {
    func getSongsForTeacher(teacherId: String) async -> Result<Songs, RequestError>
    func postSong(song: PostSong) async -> Result<Song, RequestError>
    func postDocument(songId: String, documentMultipartForm: MultipartRequest) async -> Result<Song, RequestError>
}

struct SongsService: HTTPClient, SongsServiceable {
    func getSongsForTeacher(teacherId: String) async -> Result<Songs, RequestError> {
        return await sendRequest(endpoint: SongEndpoint.getSongsForTeacher(teacherId: teacherId), responseModel: Songs.self)
    }
    
    func postSong(song: PostSong) async -> Result<Song, RequestError> {
        return await sendRequest(endpoint: SongEndpoint.postSong(song: song), responseModel: Song.self)
    }
    
    func postDocument(songId: String, documentMultipartForm: MultipartRequest) async -> Result<Song, RequestError> {
        return await sendRequest(endpoint: SongEndpoint.postDocument(songId: songId, documentMultipartForm: documentMultipartForm), responseModel: Song.self)
    }
    
}
