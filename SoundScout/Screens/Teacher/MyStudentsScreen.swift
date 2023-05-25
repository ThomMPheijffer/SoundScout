//
//  MyStudentsView.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/05/2023.
//

import SwiftUI

struct MyStudentsScreen: View {
    var columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    @State private var contentSize: CGSize = .zero
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                    ForEach(0..<10, id: \.self) { i in
                        NavigationLink(destination: StudentProfileScreen()) {
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
                            .modifier(SizeModifier())
                            .onPreferenceChange(SizePreferenceKey.self) { self.contentSize = $0 }
                        }
                    }
                }
                HStack {
                    NavigationLink(destination: Text("jflasdfjslkf")) {
                        SSPrimaryNavigationButtonText(text: "Past students")
                    }
                    .frame(maxWidth: contentSize.width, alignment: .leading)
                    .padding(.top, 16)
                    
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("My Students")
        }
    }
}

struct MyStudentsView_Previews: PreviewProvider {
    static var previews: some View {
        MyStudentsScreen()
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizeModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}
