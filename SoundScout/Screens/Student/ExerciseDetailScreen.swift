//
//  ExerciseDetailScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 12/06/2023.
//

import SwiftUI

struct ExerciseDetailScreen: View {
    let song: Song
    let exercise: Exercise
    
    @State var practises = [Exercise]()
    
    @State var importFile = false
    @State var selectedURL: URL? = nil
    @State var added = false
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollView {
                VStack {
                    HStack(spacing: 32) {
                        if let coverUrl = URL(string: song.coverUrl ?? "") {
                            AsyncImage(url: coverUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.purple.opacity(0.1)
                            }
                            .frame(width: 220, height: 220)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        } else {
                            Color.green
                                .frame(width: 220, height: 220)
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(song.title)
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 8)
                            Text(song.artist)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            NavigationLink(destination: ExercisesOverviewScreen(song: song)) {
                                SSPrimaryNavigationButtonText(text: "Practise", fullWidth: false)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 64)
                    
                    Divider()
                        .padding(.trailing, -16)
                        .padding(.bottom, 64)
                    
                    SSContentBackground(padding: 32, horizontalPaddingOnly: true) {
                        Text("History")
                            .font(.title2)
                            .bold()
                            .padding(.top, 32)
                        
                        Divider()
                            .padding(.horizontal, -32)
                        
                        ForEach(0..<practises.count, id: \.self) { i in
                            HStack {
                                if let coverUrl = URL(string: song.coverUrl ?? "") {
                                    AsyncImage(url: coverUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Color.purple.opacity(0.1)
                                    }
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(4)
                                    .shadow(radius: 2)
                                } else {
                                    Color.green
                                        .frame(width: 40, height: 40)
                                }
                                
//                                VStack(alignment: .leading) {
//                                    Text(practises[i].title)
//                                    Text(practises[i].artist)
//                                        .foregroundColor(.secondary)
//                                }

                                Spacer()

                                NavigationLink(destination: Text("Practise details")) {
                                    HStack {
                                        Text("Details")
                                        Image(systemName: "chevron.right")
                                    }
                                    .font(.callout)
                                    .bold()
                                }
                            }
                            .font(.callout)
                            .padding(.vertical)

                            if i != (practises.count - 1) {
                                Divider()
                                    .padding(.horizontal, -32)
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            
            Divider()
            
            VStack {
                Text("Progress")
                
                Text("Chart")
                
                Spacer()
                
                Button {
                    importFile = true
                } label: {
                    Text("Browse files")
                }
                .onChange(of: added) { newValue in
                    Task {
                        guard let urlPath = selectedURL else { return }
                        selectedURL = nil
                        added = false
                        
                        let pdfData = try! Data(contentsOf: urlPath)
                        
                        var multipart = MultipartRequest()
                        
                        multipart.add(
                            key: "document",
                            fileName: "Test.pdf",
                            fileMimeType: "application/pdf",
                            fileData: pdfData
                        )
                        
                        /// Create a regular HTTP URL request & use multipart components
                        let url = URL(string: "https://api-ztqk.onrender.com/exercises/6486dfab7ca2611e33302ecd/add-document")!
                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        request.setValue(multipart.httpContentTypeHeadeValue, forHTTPHeaderField: "Content-Type")
                        request.httpBody = multipart.httpBody
                        
                        /// Fire the request using URL sesson or anything else...
                        let (data, response) = try await URLSession.shared.data(for: request)
                        
                        print((response as! HTTPURLResponse).statusCode)
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width / 4)
        }
        .navigationTitle(exercise.title)
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $importFile) {
            ProjectDocumentPicker(selectedUrl: $selectedURL, added: $added)
        }
    }
}



















import Foundation
import SwiftUI

struct ProjectDocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedUrl: URL?
    @Binding var added: Bool
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        controller.allowsMultipleSelection = false
        controller.shouldShowFileExtensions = true
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> DocumentPickerCoordinator {
        DocumentPickerCoordinator(selectedUrl: $selectedUrl, added: $added)
    }
    
}
class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate {
    @Binding var selectedUrl: URL?
    @Binding var added: Bool

    init(selectedUrl: Binding<URL?>, added: Binding<Bool> ) {
        self._selectedUrl = selectedUrl
        self._added = added
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        selectedUrl = url
        added = true
    }
    
}
