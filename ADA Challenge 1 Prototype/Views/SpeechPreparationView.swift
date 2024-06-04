//
//  SpeechPreparationView.swift
//  ADA Challenge 1 Prototype
//
//  Created by Ryan Kusnadi on 31/03/24.
//

import SwiftUI

struct SpeechPreparationView: View {
    
    @State var isCountShown : Bool = false
    @Binding var isPrepShown : Bool
    
    @ObservedObject var modelPrompt = RandomPrompt()

    
    func toggleCountShown() {
        isCountShown.toggle()
    }
    
    struct Constants {
        static let White: Color = .white
        static let Grey1: Color = Color(red: 0.85, green: 0.85, blue: 0.85)
        static let Black: Color = Color(red: 0.37, green: 0.37, blue: 0.37)
        static let Blue: Color = Color(red: 0.11, green: 0.41, blue: 0.76)
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                //kotak putih isi arrow dan title screen diatas
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
                            
                            HStack {
                                Spacer()
                                Image(systemName: "xmark")
                                    .frame(width: 8, height: 14.5)
                                    .onTapGesture {
                                        isPrepShown.toggle()
                                    }
                                Spacer().frame(width: 30)

                            }
                            .padding() // Jarak arrow dan pojok kiri screen
                        }
                    )
                
                Divider()
                
                
                //progress bar + timer
                VStack {
                    Spacer().frame(height: 10)
                    CountdownTimerView(maxTime: 180) {
                        toggleCountShown()
                        print("Countdown finished!")
                    }
                    
                    //label instruksi
                    Text("Read, prep, and speak! Your prompt's below. You've got 3 mins. Tap speak button when ready!")
                        .font(Font.custom("Inter", size: 14))
                        .foregroundColor(Constants.Black)
                        .frame(width: 336, alignment: .topLeading)
                    
                }
                .frame(maxHeight: 100)
                
                VStack {
                    Spacer()
                    PromptCard(prompt: modelPrompt.prompt)
                }
                .frame(maxHeight: 200)
                
                //Context info
                VStack {
                    Text("Context Info")
                        .font(.system(size: 20, weight: .bold))
                        .frame(width:330, alignment: .leading)
                    
                    Text(modelPrompt.contextSlide)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 16, weight: .regular))
                        .frame(width:330, alignment: .topLeading)
                        .frame(maxHeight: 180)
                }
                
                Spacer()
                
                HStack(alignment: .center, spacing: 8) {
                    Text("Speak Now")
                        .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)}
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .frame(width: 336, height: 62, alignment: .center)
                .background(Constants.Blue)
                .cornerRadius(8)
                .onTapGesture {
                    toggleCountShown()
                }
                
                Spacer()
                
            }
            .background(.white)
            
            if isCountShown {
                CountdownView(modelPrompt: modelPrompt)
            }
        }
    }
    
}

#Preview {
    SpeechPreparationView(isPrepShown: .constant(false))
}
