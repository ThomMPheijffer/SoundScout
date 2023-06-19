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
    
    @State var teachers: [Teacher] = []
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                ForEach(teachers) { teacher in
                    NavigationLink(destination: LessonsScreen(type: .student(studentId: UserDefaults.standard.string(forKey: "studentID")!, teacherId: teacher.id))) {
                        HStack {
                            if let profilePicture = URL(string: teacher.profilePicture) {
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
                                    Text("\(teacher.firstName) \(teacher.lastName)")
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
                        .modifier(MyTeacherSizeModifier())
                        .onPreferenceChange(MyTeacherSizePreferenceKey.self) { self.contentSize = $0 }
                    }
                }
            }
        }
        .padding()
        .navigationTitle("My Teachers")
        .task {
            guard let studentId = UserDefaults.standard.string(forKey: "studentID") else { return }
            let result = await StudentsService().getTeachers(studentId: studentId)
            switch result {
            case .success(let data):
                print(data)
                self.teachers = data.teachers
            case .failure(let failure):
                print(failure)
            }
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

