//
//  TeacherProfileScreen.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 25/05/2023.
//

import SwiftUI

struct TeacherProfileScreen: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var spotify: Spotify
    
    var body: some View {
        ScrollView {
            VStack {
                SSColors.blueInactive
                    .frame(height: 220)
                    .overlay {
                        Circle()
                            .fill(SSColors.blue)
                            .shadow(radius: 6)
                            .frame(width: 185, height: 185)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .offset(y: 110)
                    }
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Walter Nikolic")
                            .font(.title2)
                            .bold()
                        Text("The Hague, Netherlands")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("$100")
                            .font(.title2)
                            .bold()
                        Text("lesson")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        SSPrimaryNavigationButtonText(text: "Book a lesson", fullWidth: false)
                    }
                    
                    Button(action: {}) {
                        SSSecondaryNavigationButtonText(text: "Message")
                    }
                }
                .padding()
                .padding(.top, 92)
                
                SSContentBackground(padding: 16) {
                    Text("About")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies felis eu enim consequat, nec luctus enim posuere. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque hendrerit nunc nunc, at cursus tortor interdum at. Ut eget vehicula lacus. Nam non fermentum nulla.")
                        .foregroundColor(.secondary)
                }
                .padding([.horizontal, .top])
                
                SSContentBackground(padding: 16) {
                    Text("Skills")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    HStack(spacing: 64) {
                        Text("Piano")
                            .bold()
                        Text("Teaching")
                            .bold()
                        Text("Music theory")
                            .bold()
                        Text("Work with children")
                            .bold()
                        Spacer()
                    }
                    .foregroundColor(.secondary)
                }
                .padding([.horizontal, .top])
                
                SSContentBackground(padding: 16) {
                    Text("Experience")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding([.horizontal, .top])
                
                SSContentBackground(padding: 16) {
                    Text("Showcase")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    HStack {
                        Color.black.opacity(0.3)
                            .frame(height: 240)
                            .cornerRadius(8)
                        
                        Color.black.opacity(0.3)
                            .frame(height: 240)
                            .cornerRadius(8)
                    }
                }
                .padding([.horizontal, .top])
                
                SSContentBackground(padding: 16) {
                    HStack(alignment: .bottom) {
                        Text("Reviews")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star")
                        }
                        .foregroundColor(.yellow)
                        .font(.title2)
                        .bold()
                        
                        Text("4.2 out 5")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                        .padding(.vertical)
                        .padding(.horizontal, -16)
                    
                    ForEach(0..<2, id: \.self) { i in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Kevin")
                                    .font(.headline)
                                    .bold()
                                
                                HStack(spacing: 0) {
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star")
                                }
                                .foregroundColor(.yellow)
                                .font(.headline)
                                .bold()
                            }
                            Text("Great first lesson. I am looking forward to the next")
                            Text("April 11, 2023")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                            if i != 1 {
                                Divider()
                                    .padding(.vertical)
                                    .padding(.horizontal, -16)
                            }
                        }
                    }
                    
                }
                .padding()
                
                Button("Logout") {
                    UserDefaults.standard.set(nil, forKey: "studentUserID")
                    UserDefaults.standard.set(nil, forKey: "teacherUserID")
                    
                    let vc = UIHostingController(rootView: SignUpScreen().environmentObject(navigationManager).environmentObject(spotify))
                    replaceKeyWindow(with: vc)
                }
                
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct TeacherProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeacherProfileScreen()
    }
}
