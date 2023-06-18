//
//  AudioRecorder.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 18/06/2023.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var timer : String = "0:00"
    
    override init() {
        super.init()
    }
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    var audioRecorder: AVAudioRecorder!
    
    @Published var recordingURL: URL? = nil
    
    var isRecording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            isRecording = true
            
            recordingURL = audioFilename
            
            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
                self.countSec += 1
                self.timer = covertSecToMinAndHour(seconds: self.countSec)
            })
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        isRecording = false
        timerCount?.invalidate()
    }
    
    func deleteRecording() {
        guard let recordingURL = recordingURL else { return }
        do {
            try FileManager.default.removeItem(at: recordingURL)
            self.recordingURL = nil
        } catch {
            print("File could not be deleted!")
        }
        
    }
}

extension Date {
    func toString(dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
