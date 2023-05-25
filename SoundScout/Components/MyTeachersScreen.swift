//
//  MyTeachersScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 25.5.23..
//

import SwiftUI

struct MyTeachersScreen: View {
    var columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    @State private var contentSize: CGSize = .zero
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                    ForEach(0..<10, id: \.self) { i in
                        HStack {
                            Color.blue
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Walter Nikolic")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.blue)
                                }
                                
                                Text("Online")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                
                                Text("Next lesson: Wednesday")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.05).cornerRadius(16))
                        .modifier(MyTeacherSizeModifier())
                        .onPreferenceChange(MyTeacherSizePreferenceKey.self) { self.contentSize = $0 }
                    }
                }
                HStack {
                    NavigationLink(destination: Text("jflasdfjslkf")) {
                        SSPrimaryNavigationButtonText(text: "Past teachers")
                    }
                    .frame(maxWidth: contentSize.width, alignment: .leading)
                    .padding(.top, 16)
                    
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("My Teachers")
        }
    }
}

struct MyTeachersView_Previews: PreviewProvider {
    static var previews: some View {
        MyTeachersScreen()
    }
}

struct MyTeacherSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct MyTeacherSizeModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: MyTeacherSizePreferenceKey.self, value: geometry.size)
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}
