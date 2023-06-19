//
//  SelectInstruments.swift
//  SoundScout
//
//  Created by Mina Janicijevic on 21.5.23..
//

import SwiftUI

struct SelectInstrumentsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var instruments: [Instrument] = []
    @Binding var selectedIds: [String]
    
    var body: some View {
        HStack {
            SSContentBackground {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Search")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 8)
                        
                        TextField("Search instruments", text: .constant(""))
                            .padding(.leading, 4)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(SSColors.blue.opacity(0.3), lineWidth: 1)
                            )
                        
                        Color.gray
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 32)
                            .padding(.horizontal, -32)
                        
                        ForEach(instruments) { instrument in
                            Button(action: { selectedIds.contains(instrument.id) ? selectedIds.removeAll { $0 == instrument.id } : selectedIds.append(instrument.id) }) {
                                HStack {
                                    SSCheckbox(isEnabled: selectedIds.contains(instrument.id))
                                    Text(instrument.name)
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                .padding()
                                .background(SSColors.blue.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(SSColors.blue.opacity(selectedIds.contains(instrument.id) ? 1 : 0), lineWidth: 2)
                                )
                                .cornerRadius(8)
                                .padding(.bottom, 16)
                                
                            }
                        }
                        
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Select instruments").navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button { presentationMode.wrappedValue.dismiss() } label: {
//                    SSPrimaryNavigationButtonText(text: "Done")
                    Text("Done")
                }
            }
        }
        .task {
            let result = await InstrumentsService().getAllInstruments()
            switch result {
            case .success(let instruments):
                print(instruments)
                self.instruments = instruments.instruments
            case .failure(let failure):
                print("FAILURE")
                print(failure)
            }
        }
    }
}

struct SelectInstrumentsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectInstrumentsScreen(selectedIds: .constant([]))
    }
}

