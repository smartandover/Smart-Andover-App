//
//  ImagePicker.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/12/21.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    let imageSource: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        return ImagePickerView.Coordinator(isShown: $isShown, image: $image)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let vc = UIImagePickerController()
        
        vc.sourceType = imageSource
        vc.delegate = context.coordinator
        vc.allowsEditing = false
        
        return vc
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // To conform to UIViewControllerRepresentable protocol
    }
    
    
}

extension ImagePickerView {
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var isShown: Bool
        @Binding var image: UIImage?
        
        init (isShown: Binding<Bool>, image: Binding<UIImage?>) {
            _isShown = isShown
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // If allowsEditing = true, use the .editedImage key, otherwise .originalImage
            
            image = info[.originalImage] as? UIImage
            isShown = false
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
        
    }
    
}
