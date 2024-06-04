//
//  ContentView.swift
//  loadingPage
//
//  Created by Rangga Yudhistira Brata on 02/04/24.
//

import SwiftUI
import Lottie

struct CountdownView: View {
    @State var isRecShown : Bool = false
    
    @State private var isAnimating = false
    @State var counter: Int = 3
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Add this line

    let modelPrompt: RandomPrompt

    
    var body: some View {
        ZStack {
            Color(hex: 0x3D5EAB).ignoresSafeArea()
            
            VStack {
                LottieView(animation: .named("StarAnimation.json"))
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    .padding()
                
                // Text dengan efek animasi
                AnimatedText(text: "Starting in... \(counter)", isAnimating: $isAnimating)
                    .font(Font.custom("SF Pro", size: 17).weight(.semibold))
                    .foregroundColor(.white)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
                            isAnimating.toggle()
                        }
                    }
            }
            
            if isRecShown == true {
                SpeechRecordingView(modelPrompt: modelPrompt)
            }
            
            
        }.onReceive(timer) { _ in // Add this block
            if counter > 0 {
                counter -= 1
            } else {
                timer.upstream.connect().cancel() // Stop the timer when the counter reaches 0
                onTimerEnd()
            }
        }
    }
    
    // Function to be called when the timer reaches 0
        func onTimerEnd() {
            isRecShown = true
        }

}

#Preview {
    CountdownView(modelPrompt: RandomPrompt())
}
