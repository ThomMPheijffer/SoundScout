//
//  FindTeachersScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 21.5.23..
//

import SwiftUI

struct FindTeachersScreen: View {
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
                                
                                Text("$32")
                                    .font(.body)
                                    .foregroundColor(SSColors.blue)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.05).cornerRadius(16))
                        .modifier(StudentSizeModifier())
                        .onPreferenceChange(StudentSizePreferenceKey.self) { self.contentSize = $0 }
                    }
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                HStack {
                                    Text("Find teachers")
                                        .font(.title2).bold()
                                    Spacer()
                                    Button(action: {

                                    }) {
                                        Text("Search")
                                            .foregroundColor(.blue)
                                    }
                                    Button(action: {
                                    }) {
                                        Text("Filter")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                    }
                }
            }

struct FindTeachersScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FindTeachersScreen()
    }
}

struct StudentSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct StudentSizeModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}
