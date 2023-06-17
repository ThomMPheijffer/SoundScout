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
    
    @State var students: [Student] = []
    
    var body: some View {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                    ForEach(students) { student in
                        NavigationLink(destination: LessonsScreen(student: student, teacher: nil)) {
                            HStack {
                                if let profilePicture = URL(string: student.profilePicture) {
                                    AsyncImage(url: profilePicture) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Circle()
                                            .fill(SSColors.blue)
                                            .opacity(0.1)
                                    }
                                    
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(40)
                                    .clipped()
                                } else {
                                    Color.blue
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(40)
                                }
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("\(student.firstName) \(student.lastName)")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.blue)
                                    }
                                    
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
            }
            .padding()
            .navigationTitle("My Students")
            .task {
                guard let teacherId = UserDefaults.standard.string(forKey: "teacherID") else { return }
                let result = await TeachersService().getStudents(teacherId: teacherId)
                switch result {
                case .success(let data):
                    print(data)
                    self.students = data.students
                case .failure(let failure):
                    print(failure)
                }
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
