//
//  ProjectDocumentPicker.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/06/2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct SSProjectDocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedUrl: URL?
    @Binding var added: Bool
    let fileTypes: [UTType]
    
    init(selectedUrl: Binding<URL?>, added: Binding<Bool>, fileTypes: [UTType] = [.pdf]) {
        self._selectedUrl = selectedUrl
        self._added = added
        self.fileTypes = fileTypes
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: fileTypes)
        controller.allowsMultipleSelection = false
        controller.shouldShowFileExtensions = true
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
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

