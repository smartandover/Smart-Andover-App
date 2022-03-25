//
//  ImagePicker.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/12/21.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    let imageSource: UIImagePickerController.SourceType
    let allowsEditing: Bool
    
    init (isShown: Binding<Bool>, image: Binding<UIImage?>, imageSource: UIImagePickerController.SourceType, allowsEditing: Bool = false) {
        _isShown = isShown
        _image = image
        self.imageSource = imageSource
        self.allowsEditing = allowsEditing
    }
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(isShown: $isShown, image: $image, allowsEditing: allowsEditing)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let vc = UIImagePickerController()
        
        vc.sourceType = imageSource
        vc.delegate = context.coordinator
        vc.allowsEditing = allowsEditing
        
        return vc
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // To conform to UIViewControllerRepresentable protocol
    }
    
    
}

extension ImagePicker {
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var isShown: Bool
        @Binding var image: UIImage?
        
        let allowsEditing: Bool
        
        init (isShown: Binding<Bool>, image: Binding<UIImage?>, allowsEditing: Bool) {
            _isShown = isShown
            _image = image
            self.allowsEditing = allowsEditing
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // If allowsEditing = true, use the .editedImage key, otherwise .originalImage
            
            image = info[allowsEditing ? .editedImage : .originalImage] as? UIImage
            isShown = false
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
        
    }
    
}
