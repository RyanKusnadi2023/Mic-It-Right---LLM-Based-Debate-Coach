//
//  AudioRecorderView.swift
//  ADA Challenge 1 Prototype
//
//  Created by Ryan Kusnadi on 01/04/24.
//

import SwiftUI

struct AudioRecorderView: View {
    @StateObject private var audioRecorder = AudioRecorder()
    
    @State private var text = "Transcription here"
    
    var body: some View {
        VStack {
            if audioRecorder.isRecording {
                Button("Stop Recording") {
                    audioRecorder.stopRecording()
                }
            } else {
                Button("Start Recording") {
                    audioRecorder.startRecording()
                }
            }
            
            if !audioRecorder.isRecording && audioRecorder.hasRecording {
                Button("Play Recording") {
                    audioRecorder.playRecording()
                }
                Button("Transcribe Recording") {
                    audioRecorder.transcribeAudio { transcript in
                        DispatchQueue.main.async {
                            text = transcript
                        }
                    }
                }
            }
            
            Text("\(text)")
        }
        .padding()
        .onAppear() {
            audioRecorder.setupAudioSession()
        }
    }
}



#Preview {
    AudioRecorderView()
}
