//
//  SongDetailScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 22/05/2023.
//

import SwiftUI

struct SongDetailScreen: View {
    let song: Song
    
    var body: some View {
        ScrollView(showsIndicators: false) {
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
                    
                    HStack {
                        Button(action: {}) {
                            SSSecondaryNavigationButtonText(text: "Play")
                        }
                        NavigationLink(destination: ExercisesOverviewScreen(song: song)) {
                            SSPrimaryNavigationButtonText(text: "Interactive Exercises", fullWidth: false)
                        }
                        
                        Spacer()
                    }
                }
                
            }
            .padding(.bottom, 64)
            
            SSContentBackground(padding: 16) {
                Text("Teacher notes")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                Text(song.teacherNotes)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 32)
            
            SSContentBackground(padding: 16) {
                Text("Additional resources")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if song.documentUrls.count != 0 {
                    ForEach(song.documentUrls, id: \.self) { url in
                        #warning("Refactor this to make it async")
                        NavigationLink(destination: PDFKitRepresentedView(try! Data(contentsOf: URL(string: url)!))) {
                            HStack {
                                Image(systemName: "doc")
                                Text((URL(string: url)!.lastPathComponent as NSString).deletingPathExtension)
                                    .underline()
                            }
                            .foregroundColor(.secondary)
                        }
                    }
                } else {
                    Text("No additional resources provided for this song.")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}





import PDFKit
import SwiftUI

struct PDFKitRepresentedView: UIViewRepresentable {
    typealias UIViewType = PDFView

    let data: Data
    let singlePage: Bool

    init(_ data: Data, singlePage: Bool = false) {
        self.data = data
        self.singlePage = singlePage
    }

    func makeUIView(context _: UIViewRepresentableContext<PDFKitRepresentedView>) -> UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        if singlePage {
            pdfView.displayMode = .singlePage
        }
        return pdfView
    }

    func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<PDFKitRepresentedView>) {
        pdfView.document = PDFDocument(data: data)
    }
}
