//
//  ScheduleScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 24.5.23..
//

import SwiftUI

struct ScheduleScreen: View {
    enum UserType {
        case student
        case teacher
    }
    
    let userType: UserType
    
    var body: some View {
        Color(uiColor: UIColor(red: 240/253, green: 241/253, blue: 245/253, alpha: 0.8))
            .cornerRadius(8)
            .overlay(
                VStack(spacing: 0) {
                    header
                    Group {
                        Divider()
                        generateRow(for: [31, 1, 2, 3, 4, 5, 6], noHighlight: [31])
                        Divider()
                        generateRow(for: [7, 8, 9, 10, 11, 12, 13], appointments: [10])
                        Divider()
                        generateRow(for: [14, 15, 16, 17, 18, 19, 20], appointments: [15])
                        Divider()
                        generateRow(for: [21, 22, 23, 24, 25, 26, 27], appointments: [27])
                        Divider()
                        generateRow(for: [28, 29, 30, 1, 2, 3, 4], noHighlight: [1, 2, 3, 4])
                    }
                    
                }
            )
            .padding()
            .navigationTitle("August 2023")

    }
    
    var header: some View {
        HStack(spacing: 0) {
            ForEach(["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"], id: \.self) { day in
                Text(day)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if day != "SUN" {
                    Divider()
                }
                
            }
        }
        .frame(maxHeight: 70)
    }
    
    func generateRow(for days: [Int], noHighlight: [Int] = [], appointments: [Int] = []) -> some View {
        HStack(spacing: 0) {
            ForEach(days, id: \.self) { day in
                VStack(spacing: 0) {
                    Text("\(day)")
                        .foregroundColor(noHighlight.contains { $0 == day } ? .secondary : .primary)
                        .bold()
                        .padding()

                    if appointments.contains(where: { $0 == day }) {
                        appointmentView
                    } else {
                        Spacer()
                    }
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .frame(maxWidth: .infinity, alignment: .center)
                
                if day != days.last! {
                    Divider()
                }
                
            }
        }
    }
    
    @ViewBuilder
    var appointmentView: some View {
        if userType == .student {
            AnyView(studentAppointmentView)
        } else {
            AnyView(teacherAppointmentView)
        }
    }
    
    var teacherAppointmentView: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .fill(SSColors.blue)
                    .frame(width: 16, height: 16)
                
                Text("Walter")
                    .font(.caption)
            }
            .padding([.horizontal, .top], 8)
            .padding(.bottom, 4)
            
            Text("14:00")
                .font(.system(size: 10))
                .foregroundColor(.secondary)
                .padding(.leading, 8)
            
            Spacer()
            
            Text("Guitar lesson")
                .font(.system(size: 10))
                .foregroundColor(.secondary)
                .padding([.horizontal, .bottom], 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .init(red: 223/253, green:236/253, blue: 253/253, alpha: 1)))
        .padding([.horizontal, .bottom])
        .cornerRadius(8)
        .clipped()
    }
    
    var studentAppointmentView: some View {
        VStack(alignment: .leading) {
            Text("Guitar lesson")
                .font(.caption2)
                .padding([.horizontal, .top], 8)
                .padding(.bottom, 4)
            Text("14:00")
                .font(.system(size: 10))
                .foregroundColor(.secondary)
                .padding(.leading, 8)
            
            Spacer()
            
            HStack {
                Circle()
                    .fill(SSColors.blue)
                    .frame(width: 16, height: 16)
                
                Text("Walter")
                    .font(.system(size: 10))
            }
            .padding([.horizontal, .bottom], 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .init(red: 223/253, green:236/253, blue: 253/253, alpha: 1)))
        .padding([.horizontal, .bottom])
        .cornerRadius(8)
        .clipped()
    }
    
}

struct ScheduleScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleScreen(userType: .student)
    }
}

