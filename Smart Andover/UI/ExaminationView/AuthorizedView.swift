//
//  AuthorizedView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/15/21.
//

import SwiftUI
import Firebase

struct AuthorizedView: View {
    
    @Environment(\.currentUser) var user
    @State var documents: [PhotoDocument]?
    @State var currentDocument: PhotoDocument? = nil
    
    var body: some View {
        
        if !user.wrappedValue!.authority.isAuthorized {
            
            //Unauthorized view
                //Shouldn't pop up, but in the case of a bug
            Text("Unauthorized")
            
        }
        
        else {
            
            if let documents = documents {
                
                ZStack {
                    
                    if let currentDocument = currentDocument {
                        
                        Color.themeLight
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .ignoresSafeArea()
                            .zIndex(1)
                        
                        PhotoInspectionView(document: currentDocument, selection: $currentDocument.animation())
                            .zIndex(2)
                            .transition(.move(edge: .bottom))
                        
                    }
                    
                    VStack {
                        
//                        Label(Pages.authorized.title, systemImage: Pages.authorized.systemImageName)
//                            .font(.title.bold())
                    
                        ScrollView {
                            
                            let layout = [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ]
                                
                            LazyVGrid(columns: layout) {
                                
                                ForEach(documents, id: \.self) { document in
                                    
                                    ZStack {
                                        Color.clear
                                        Image(uiImage: UIImage(data: document.photoData) ?? UIImage(named: "SmartAndoverSquare")!)
                                            .resizable()
                                            .scaledToFill()
                                            .layoutPriority(-1)
                                    }
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipped()
                                    .onTapGesture {
                                        withAnimation {
                                            currentDocument = document
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        .padding()
                        .onDisappear {
                            self.documents = nil
                        }
                        
                    }
                    
                }
                
            }
            else {
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .theme))
                    .onAppear {
                        
                        DatabaseController.database
                            .collection("PendingPhotos")
                            .order(by: "dateSubmitted")
                            //Reduce Firebase read bills in potential future
                            .limit(to: 9)
                            .addSnapshotListener(includeMetadataChanges: true) { query, error in
                                
                                guard let query = query else { return }
                                
                                documents = query.documents.map({ document -> PhotoDocument in
                                    
                                    let photoData = document.data()["photoData"] as! Data
                                    let dateSubmitted = document.data()["dateSubmitted"] as! Timestamp
                                    let userEmail = document.data()["userEmail"] as! String
                                    
                                    return PhotoDocument(id: document.documentID, photoData: photoData, dateSubmitted: dateSubmitted.dateValue(), userEmail: userEmail)
                                    
                                })
                                
                                
                            }
                        
                    }
                
            }
        
        }
        
    }
    
}
