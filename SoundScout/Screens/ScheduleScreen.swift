//
//  ScheduleScreen.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 24.5.23..
//

import SwiftUI

struct ScheduleScreen: View {
    @State var selectedDate: Date = Date()
    
    var body: some View {
      //  StudentHomeScreen()
       //     .environmentObject(navigationManager)
        
                // Added DatePicker with selection equal to State variable selectedDate
                DatePicker("Select Date", selection: $selectedDate)
                          .padding(.horizontal)
        
        VStack(alignment: .center, spacing: 0) {
            Text(selectedDate.formatted(date: .abbreviated, time: .standard))
                .font(.system(size: 28))
                .bold()
                .foregroundColor(Color.accentColor)
                .padding()
                .animation(.spring(), value: selectedDate)
            Divider()
            Spacer()
            DatePicker("Select Date", selection: $selectedDate)
                .padding(.horizontal)
        }
        .padding(.vertical, 200)
        
        VStack() {
            Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                .font(.system(size: 28))
                .bold()
                .foregroundColor(Color.accentColor)
                .padding()
                .animation(.spring(), value: selectedDate)
                .frame(width: 500)
            Divider().frame(height: 1)
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .padding(.horizontal)
                .datePickerStyle(.graphical)
            Divider()
        }
        .padding(.vertical, 100)

    }
}

struct ScheduleScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleScreen()
    }
}
