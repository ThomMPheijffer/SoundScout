//
//  RecordingView.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 21/06/2023.
//

import SwiftUI

enum RecordingState {
    case identity
    case countdown
    case recording
}

struct RecordingView: View {
    @EnvironmentObject var audioRecorder: AudioRecorder
    
    @Binding var recordingState: RecordingState
    @Binding var count: Int
    @Binding var countDown: Int
    @Binding var bpm: Double
    
    @State var timer = Timer.publish(every: ((60/80.0)), on: .main, in: .common).autoconnect()
    
    var body: some View {
        Group {
            if recordingState == .identity {
                Button(action: {
                    recordingState = .countdown
                }) {
                    SSSecondaryNavigationButtonText(text: "Start recording", fullWidth: true)
                }
            }
            
            if recordingState == .countdown {
                Text("\(countDown)")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 60/bpm, repeats: true) { timer in
                            withAnimation {
                                countDown -= 1
                            }
                            if countDown == 0 {
                                timer.invalidate()
                                recordingState = .recording
                                audioRecorder.startRecording()
                                
                                count = 0
                                self.timer = Timer.publish(every: ((60/bpm)), on: .main, in: .common).autoconnect()
                            }
                        }
                    }
            }
            
            if recordingState == .recording {
                VStack {
                    HStack(spacing: 16) {
                        ForEach(0..<4) { i in
                            Capsule()
                                .frame(width: 20, height: 80)
                                .foregroundStyle(i == count ? Color.green : Color.gray)
                        }
                    }
                    .onReceive(timer) { input in
                        count += 1
                        if count == 4 { count = 0 }
                    }
                    
                    Text(audioRecorder.timer)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button(action: { timer.upstream.connect().cancel(); audioRecorder.stopRecording() }) {
                        SSSecondaryNavigationButtonText(text: "Stop recording")
                    }
                }
            }
        }
    }
}
