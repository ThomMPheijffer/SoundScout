//
//  AddSongScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 22/05/2023.
//

import SwiftUI

struct AddSongScreen: View {
    @ObservedObject var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State var importFile = false
    @State var selectedURL: URL? = nil
    @State var selectedURLs = [URL]()
    @State var added = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                SSTextField(title: "Song name", text: $viewModel.songName)
                    .padding(.bottom, 32)
                
                SSTextField(title: "Artist", text: $viewModel.artist)
                    .padding(.bottom, 32)
                
                Text("Cover art")
                    .font(.title3)
                    .padding(.bottom)
                if viewModel.coverUrl != nil {
                    AsyncImage(url: viewModel.coverUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.purple.opacity(0.1)
                    }
                    .frame(width: 120, height: 120)
                    .cornerRadius(8)
                    .padding(.bottom, 32)
                } else {
                    Button(action: {}) {
                        SSSecondaryNavigationButtonText(text: "Upload cover art")
                    }
                    .padding(.bottom, 32)
                }
                
                SSTextField(title: "Teacher notes", text: $viewModel.teacherNotes, axis: .horizontal)
                    .padding(.bottom, 32)
                
                Text("Cover art")
                    .font(.title3)
                    .padding(.bottom)
                
                ForEach(selectedURLs, id: \.self) { url in
                    Text((url.lastPathComponent as NSString).deletingPathExtension)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .padding(.bottom, 8)
                }
                
                Button(action: { importFile = true }) {
                    SSSecondaryNavigationButtonText(text: "Attach files to song")
                }
                .sheet(isPresented: $importFile) {
                    ProjectDocumentPicker(selectedUrl: $selectedURL, added: $added)
                }
                .padding(.bottom, 64)
                
                Button(action: {
                    Task {
                        print("Create song")
                        guard let song = await createSong() else { return }
                        print("Song created \(song)")
                        await uploadDocumentsFor(song: song)
                        print("documents uploaded")
                    }
                }) {
                    SSPrimaryNavigationButtonText(text: "Create song", isActive: viewModel.canContinue())
                }
                .disabled(!viewModel.canContinue())
                .padding(.bottom, 128)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Add song")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.showPopover = true }) {
                    SSPrimaryNavigationButtonText(text: "Add song via Spotify")
                }
            }
        }
        .sheet(isPresented: $viewModel.showPopover) {
            SearchSongScreen { track in
                self.viewModel.songName = track.name
                self.viewModel.artist = track.artists?.first?.name ?? self.viewModel.artist
                self.viewModel.coverUrl = track.album?.images?.first?.url
            }
        }
        .onChange(of: added) { newValue in
            Task {
                guard let urlPath = selectedURL else { return }
                selectedURLs.append(urlPath)
                
                selectedURL = nil
                added = false
            }
        }
    }
    
    func createSong() async -> Song? {
        print("createSong")
        let result = await viewModel.postSong()
        print(result)
        switch result {
        case .success(let song):
            print(song)
            return song
        case .failure(let failure):
            print(failure)
            return nil
        }
    }
    
    func uploadDocumentsFor(song: Song) async {
        print("upload urls \(selectedURLs)")
        for url in selectedURLs {
            let pdfData = try! Data(contentsOf: url)
            var multipart = MultipartRequest()
            multipart.add(
                key: "document",
                fileName: url.lastPathComponent,
                fileMimeType: "application/pdf",
                fileData: pdfData
            )
            let result = await SongsService().postDocument(songId: song.id, documentMultipartForm: multipart)
            switch result {
            case .success(let song):
                print(song)
            case .failure(let failure):
                print(failure)
            }
        }
        dismiss()
    }
    
}

struct AddSongScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddSongScreen()
    }
}
