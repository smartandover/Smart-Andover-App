//
//  Smart_AndoverApp.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/12/21.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UIScrollView.appearance().bounces = true
        FirebaseApp.configure()
        
        return true
        
    }
    
}

@main
struct Smart_AndoverApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var user: User? = User(email: "cabouezzi22@andover.edu", firstName: "Chaniel", lastName: "Abou-Ezzi", authority: .president)
    
    //For logo animation in login/register view
    @Namespace var namespace
    
    @State var showMenu: Bool = false
    @State var currentPage: Pages = .home
    
    var body: some Scene {
        
        WindowGroup {
            
            //Tutorial
            if UserDefaults.IsFirstLaunch() {
                
                TutorialView()
                
            }
            
            //Main
            else if user != nil {
                
                VStack(spacing: 0) {
                    
                    HStack {
                        
                        currentPage.label()
                            .font(.system(.title3, design: .serif))
                            .foregroundColor(.themeDark)
                            .transition(.opacity)
                            .padding()
                            .background(Color.systemBackground.ignoresSafeArea())
                        
                        Spacer()
                        
                        Image(systemName: "text.justify")
                            .font(.title3.bold())
                            .foregroundColor(.themeDark)
                            .transition(.opacity)
                            .animation(.easeOut(duration: 0.3))
                            .rotationEffect(.degrees(showMenu ? -270: 0), anchor: .center)
                            .onTapGesture {
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }
                        
                    }
                    .frame(height: 50)
                    .padding(.horizontal)
                    
//                    .background(Color.themeDark.ignoresSafeArea())
                    
                    ZStack {
                        
                        switch currentPage {
                        
                        case .home:
                            HomeView()
                            
                        case .leaderboard:
                            LeaderboardView()
                            
                        case .authorized:
                            AuthorizedView()
                                .background(Color.themeLight)
                            
                        case .profile:
                            ProfileView()
                            
                        default:
                            EmptyView()
                            
                        }
                        
                        BlurView()
                            .opacity(showMenu ? 1 : 0)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    showMenu = false
                                }
                            }
                        
                        SideMenuView(currentPage: $currentPage, isShowing: $showMenu)
                            .foregroundColor(.themeDark)
                            .background(Color.themeLight.ignoresSafeArea())
                            .animation(.easeInOut)
                            .offset(x: showMenu ? 100 : UIScreen.main.bounds.width)
                        
                    }
                        
                }
                //After matching the design to the OG, dark mode looks disgusting
                .preferredColorScheme(.light)
                .statusBar(hidden: false)
                .environment(\.currentUser, $user)
                .onAppear {
                    DatabaseController.database
                        .collection("Users")
                        .document(user!.email)
                        .addSnapshotListener { query, error in
                            
                            guard let query = query else { return }
                            
                            user?.points =  query.get("points") as! Int
                            
                        }
                }
                
            }
            
            //Login
            else {
                
                VStack(spacing: 10) {
                    
                    Spacer()
                    
                    SmartAndoverLogo()
                        .matchedGeometryEffect(id: "LOGO", in: namespace)
                        .scaleEffect(1.5)
                    
                    LoginView(user: $user)
                    
                    Spacer()
                    
                }
                .animation(.easeInOut)
                .environment(\.currentUser, $user)
                
            }
            
        }
        
    }
    
}
