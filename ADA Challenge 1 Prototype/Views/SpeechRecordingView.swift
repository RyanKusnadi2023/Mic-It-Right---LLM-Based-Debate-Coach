//
//  SpeechRecordingView.swift
//  ADA Challenge 1 Prototype
//
//  Created by Ryan Kusnadi on 31/03/24.
//

import SwiftUI

struct SpeechRecordingView: View {
    
    @StateObject private var audioRecorder = AudioRecorder()
    @State private var isGlowing = false
    @State var isRecordingDone = false
    
    
    let modelPrompt: RandomPrompt

    
    func stopAndPlay(){
        audioRecorder.stopRecording()
        //audioRecorder.playRecording()
        //ADD LOGIC NGIRIM KE NEXT PAGE
        isRecordingDone = true
        
    }
    
    struct Constants {
        static let White: Color = .white
        static let Grey1: Color = Color(red: 0.85, green: 0.85, blue: 0.85)
        static let Black: Color = Color(red: 0.37, green: 0.37, blue: 0.37)
        static let Blue: Color = Color(red: 0.11, green: 0.41, blue: 0.76)
    }
    
    var body: some View {
        
        ZStack {
            VStack (spacing: 0){
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 393, height: 40)
                    .background(Constants.White)
                    .overlay(
                        ZStack {
                            Text("Practice")
                                .font(Font.custom("Inter", size: 16).weight(.semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Constants.Black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                    )
                
                Divider()
                Spacer().frame(height: 50)
                
                CountdownTimerView(maxTime: 180, completion: stopAndPlay)
                
                //label instruksi
                Text("Speak! You have 3 minutes to deliver the arguments that you have prepared!")
                    .font(Font.custom("Inter", size: 14))
                    .foregroundColor(Constants.Black)
                    .frame(width: 336, alignment: .topLeading)
                    .frame(maxHeight: 50)
                
                Spacer().frame(height: 40)
                
                VStack {
                    Spacer()
                    PromptCard(prompt: modelPrompt.prompt)
                }
                .frame(maxHeight: 200)
                
                //Context info
                HStack {
                    Text("Recording...").onAppear(perform: {
                        audioRecorder.setupAudioSession()
                        audioRecorder.startRecording()
                    })
                    
                    ZStack {
                        Circle()
                            .foregroundColor(.red)
                            .opacity(isGlowing ? 0.3 : 0)
                            .scaleEffect(isGlowing ? 2.5 : 1.0)
                            .animation(_:
                                        Animation.easeInOut(duration: 1.0)
                                .repeatForever(autoreverses: true))
                            .frame(width: 18, height: 18) // Adjust the size of the circle here
                        Image(systemName: "mic.circle.fill")
                            .foregroundColor(.red).font(.system(size: 25))
                    }.onAppear {
                        self.isGlowing = true
                    }
                }
                
                Spacer().frame(height: 40)
                
                HStack(alignment: .center, spacing: 8) {
                    Text("Finish Speech")
                        .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)}
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .frame(width: 336, height: 62, alignment: .center)
                .background(Constants.Blue)
                .cornerRadius(8)
                .onTapGesture {
                    stopAndPlay()
                }
                
            Spacer()
            }
            .padding()
        .background(.white)
            if (isRecordingDone){
                LoadingView(userPrompt: modelPrompt.prompt, audioRecorder: audioRecorder)
            }
            
        } // Set background color to blue
        
        
    }
}


#Preview {
    SpeechRecordingView(modelPrompt: RandomPrompt())
}
/*
VStack {
    CountdownTimerView(maxTime: 15, completion: stopAndPlay)
    
    HStack {
        Text("Recording...").onAppear(perform: {
            audioRecorder.setupAudioSession()
            audioRecorder.startRecording()
        })
        
    ZStack {
        Circle()
            .foregroundColor(.red)
            .opacity(isGlowing ? 0.3 : 0)
            .scaleEffect(isGlowing ? 1.5 : 1.0)
            .animation(
                Animation.easeInOut(duration: 1.0)
                .repeatForever(autoreverses: true))
                .frame(width: 18, height: 18) // Adjust the size of the circle here
            Image(systemName: "mic.circle.fill")
                .foregroundColor(.red)
                }.onAppear {
                    self.isGlowing = true
                }
    }
}
*/
