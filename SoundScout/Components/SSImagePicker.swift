//
//  SSImagePicker.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 14/06/2023.
//

import PhotosUI
import SwiftUI

struct SSImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImageURL: URL?

    func makeUIViewController(context: UIViewControllerRepresentableContext<SSImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<SSImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: SSImagePicker

        init(_ parent: SSImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let assetPath = info[UIImagePickerController.InfoKey.imageURL] as! URL
            print(assetPath)
            if (assetPath.absoluteString.hasSuffix("JPG")) {
                print("This is JPG Image")
            } else if (assetPath.absoluteString.hasSuffix("PNG")) {
                print("This is PNG Image")
            } else if (assetPath.absoluteString.hasSuffix("GIF")) {
                print("This is GIF Image")
            } else {
                print("Other Formats are not allowed like .tiff , .gif")
            }
            
            DispatchQueue.main.async {
                self.parent.selectedImageURL = assetPath
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}
