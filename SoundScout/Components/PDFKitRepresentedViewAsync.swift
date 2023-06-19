//
//  PDFKitRepresentedViewAsync.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 19/06/2023.
//

import PDFKit
import SwiftUI


struct PDFKitRepresentedViewAsync: UIViewRepresentable {
    typealias UIViewType = PDFView

    let url: URL
    let singlePage: Bool

    init(_ url: URL, singlePage: Bool = false) {
        self.url = url
        self.singlePage = singlePage
    }

    func makeUIView(context _: UIViewRepresentableContext<PDFKitRepresentedViewAsync>) -> UIViewType {
        let pdfView = PDFView()
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            DispatchQueue.main.async {
                pdfView.document = PDFDocument(data: data)
            }
        }
        pdfView.autoScales = true
        if singlePage {
            pdfView.displayMode = .singlePage
        }
        return pdfView
    }

    func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<PDFKitRepresentedViewAsync>) {
        pdfView.document = PDFDocument(url: url)
    }
}
