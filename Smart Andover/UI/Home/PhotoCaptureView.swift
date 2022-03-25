//
//  CaptureImageButton.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/15/21.
//

import SwiftUI

struct PhotoCaptureView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.currentUser) private var user
    
    @State private var photo: UIImage?
    @State private var showActionSheet = false
    @State private var showCamera: Bool = false
    @State private var showLibrary: Bool = false
    
    @State private var submissionState: SubmissionState = .none
    
    enum SubmissionState {
        case none, submitting, success, failed(error: Error)
    }
    
    static let messages = [
        "Looking good, as usual!",
        "Truly a masterpiece!",
        "Mother nature thanks you!",
        "Sustainability is cool!"
    ]
    
    @State private var hype: String = PhotoCaptureView.messages.randomElement()!
    
    var body: some View {
        
        VStack {
            switch submissionState {
            
            case .none:
                PickerView()
                
            case .submitting:
                LoadingView()
                
            case .success:
                SuccessView()
                
            case .failed(let error):
                FailedView(error)
                
            }
        }
        .preferredColorScheme(.light)
        
    }
    
    //Fold functions when not inspecting
    
    @ViewBuilder func PickerView () -> some View {
        VStack(spacing: 10) {
            
            //Image + "hype"
            Button(action: {
                showActionSheet = true
            }, label: {
                
                VStack {
                    
                    if photo == nil {
                        Text("Tap to pick a photo.")
                            .foregroundColor(.themeDark).bold()
                    }
                    
                    (photo == nil ? Image(systemName: "camera.viewfinder") : Image(uiImage: photo!))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 200, minHeight: 200)
                        .cornerRadius(20)
                        .foregroundColor(.themeLight)
                        .bubbleStyle(color: .systemBackground, padding: 10)
                    
                }
                
            })
            .padding(.horizontal, 40)
            .padding(.top, 20)
            
            if photo == nil {
                Button("Back", action: dismiss)
            }
            
            if photo != nil {
                
                Text(hype)
                    .foregroundColor(.themeDark).bold()
                    .padding(.horizontal, 40)
                    .multilineTextAlignment(.center)
                
                // Submission button
                AlertButton(label: Text("Submit"),
                            title: Text("Submit photo?"),
                            message: Text("Are you sure you want to submit this photo? You cannot undo this action."),
                            primaryButton: .cancel(),
                            secondaryButton: .default(Text("Submit"), action: submitToDatabase))
                    .buttonStyle(BarButtonStyle(tint: .green))
                    .padding(.horizontal)
                
                // 'Choose another' button
                Button("Choose Another Photo") {
                    showActionSheet = true
                }
                    .buttonStyle(BarButtonStyle(tint: .theme))
                    .foregroundColor(.theme)
                    .padding(.horizontal)
                
                // Cancel button
                AlertButton(label: Text("Nevermind"),
                            title: Text("Are you sure?"),
                            message: Text("This photo will be lost forever if not already saved on this device."),
                            primaryButton: .cancel(),
                            secondaryButton: .destructive(Text("Delete"), action: dismiss))
                    .foregroundColor(.red)
                    .padding(.horizontal)
                
            }

            
            Color.clear.frame(height: 0)
                // Picker
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Choose a method."),
                                buttons: [
                                    .default(Text("Take Photo"), action: { showCamera = true }),
                                    .default(Text("Choose From Library"), action: { showLibrary = true }),
                                    .cancel()
                                ])
                }
            Color.clear.frame(height: 0)
                // Camera
                .fullScreenCover(isPresented: $showCamera) {
                    ImagePicker(isShown: $showCamera, image: $photo, imageSource: .camera)
                        .ignoresSafeArea()
                }
            Color.clear.frame(height: 0)
                // Library
                .sheet(isPresented: $showLibrary) {
                    ImagePicker(isShown: $showLibrary, image: $photo, imageSource: .photoLibrary)
                }
            
        }
    }
    
    @ViewBuilder func LoadingView () -> some View {
        
        VStack {
            
            Spacer()
            
            ProgressView("Hang tight!")
                .font(.subheadline.bold())
                .progressViewStyle(CircularProgressViewStyle(tint: .themeDark))
            
            Text("We're sending your photo now. If this action takes too long, there may be a problem with your network connection.")
                .font(.caption2)
            
            Spacer()
            
        }
        .foregroundColor(.themeDark)
        .multilineTextAlignment(.center)
        .padding()
        
    }
    
    @ViewBuilder func SuccessView () -> some View {
        
        VStack (spacing: 5) {
        
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.themeDark)
            
            Text("All set! A Smart Andover board member will review your photo soon.")
                .padding()
                .multilineTextAlignment(.center)
            
            Button("Close", action: dismiss)
            
        }
        
    }
    
    @ViewBuilder func FailedView (_ error: Error) -> some View {
        
        VStack (spacing: 5) {
            
            Image(systemName: "exclamationmark.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.themeDark)
            
            VStack {
                Text("Uh oh! The following error occurred.")
                    .foregroundColor(.themeDark).bold()
                Text(error.localizedDescription)
                    .foregroundColor(.red)
                Text("If there seems to be a problem with the app, please contact the Smart Andover team with the error and necessary information.")
                .foregroundColor(.themeDark)
            }
            .padding()
            .multilineTextAlignment(.center)
            
            Button("Close", action: dismiss)
            
        }
        
    }
    
    
    func dismiss () {
        self.photo = nil
        presentationMode.wrappedValue.dismiss()
    }
    
    func submitToDatabase () {
        
        submissionState = .submitting
        
        // Submit to databse
        
        if let image = photo {
        
            DatabaseController.uploadPhoto(user: user.wrappedValue!, photo: image) { error in
                
                if let error = error {
                    print("Error when submitting photo: \(error)")
                    withAnimation {
                        submissionState = .failed(error: error)
                    }
                }
                else {
                    self.photo = nil
                    withAnimation {
                        submissionState = .success
                    }
                }
                
            }
        }
        
        self.photo = nil
        
    }
    
}


extension UIImage: Identifiable {
    
    public var id: ObjectIdentifier {
        ObjectIdentifier(Self.self)
    }
    
}
