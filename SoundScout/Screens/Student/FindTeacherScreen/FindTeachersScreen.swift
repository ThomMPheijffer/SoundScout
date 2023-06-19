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
    @State private var searchText = ""
    
    @State var teachers: [Teacher] = []
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                ForEach(teachers, id: \.id) { teacher in
                    NavigationLink(destination: TeacherProfileScreen(loadedTeacher: teacher, canConnect: true)) {
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
                                        .foregroundColor(.primary)
                                }
                                
                                Text(ListFormatter.localizedString(byJoining: teacher.instruments.map { $0.name }))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                
                                Text("$\(teacher.hourlyRate)")
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
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: FilterScreen()) {
//                    SSPrimaryNavigationButtonText(text: "Filter")
                    Text("Filter")
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search songs")
        .task {
            let result = await TeachersService().getAllTeachers()
            switch result {
            case .success(let teachers):
                print(teachers)
                self.teachers = teachers.teachers
            case .failure(let failure):
                print("FAILURE")
                print(failure)
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
