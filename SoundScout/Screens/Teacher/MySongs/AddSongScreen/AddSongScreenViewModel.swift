//
//  AddSongScreenViewModel.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import Foundation

extension AddSongScreen {
    class ViewModel: ObservableObject {
        @Published var showPopover = false
        
        @Published var songName: String = ""
        @Published var artist: String = ""
        @Published var coverUrl: URL? = nil
        @Published var teacherNotes: String = ""
        
        func postSong() async -> Result<Song, RequestError> {
            guard let teacherId = UserDefaults.standard.string(forKey: "teacherID") else { return .failure(.unknown) }
            let result = await SongsService().postSong(song: .init(teacherId: teacherId, title: songName, artist: artist, teacherNotes: teacherNotes, url: coverUrl))
            return result
        }
        
        func canContinue() -> Bool {
            return !songName.isEmpty && !artist.isEmpty && !teacherNotes.isEmpty
        }
    }
}
