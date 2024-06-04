//
//  GuidlineView.swift
//  ADA Challenge 1 Prototype
//
//  Created by Rio Ikhsan on 03/04/24.
//

import SwiftUI

struct GuidelineView: View {
    
    @Binding var isGuideShown : Bool
    @State var isPrepShown = false
    
    struct Constants {
        static let White: Color = .white
        static let Grey1: Color = Color(red: 0.85, green: 0.85, blue: 0.85)
        static let Black: Color = Color(red: 0.37, green: 0.37, blue: 0.37)
        static let Blue: Color = Color(red: 0.11, green: 0.41, blue: 0.76)
    }
    
    var body: some View {
        VStack {
                //kotak putih isi arrow dan title screen diatas
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 393, height: 40)
                    .background(Constants.White)
                    .overlay(
                        ZStack {
                            Text("")
                                .font(Font.custom("Inter", size: 16).weight(.semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Constants.Black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            
                            HStack {
                                Spacer()
                                Image(systemName: "xmark")
                                    .frame(width: 8, height: 14.5)
                                    .onTapGesture {
                                        isGuideShown.toggle()
                                    }
                                Spacer().frame(width: 30)

                            }
                            .padding() // Jarak arrow dan pojok kiri screen
                        }
                    )
                
            Divider().opacity(0)
                Spacer()
            
            
            HStack {
                Text("Guidelines")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.leading)
                Spacer()
            } .padding()
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 333, height: 490)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.18), lineWidth: 1)
                    )
                
                VStack{
                    HStack {
                        NumberCircleView(number: 1)
                        Text("You will be given a random prompt and context slide.")
                            .font(Font.custom("SF Pro", size: 16))
                            .foregroundColor(.black)
                    } .frame(maxWidth: 300, maxHeight: 50, alignment: .leading)
                    HStack {
                        NumberCircleView(number: 2)
                        Text("You have 3 minutes to read and prepare your speech.")
                            .font(Font.custom("SF Pro", size: 16))
                            .foregroundColor(.black)
                    } .frame(maxWidth: 300, maxHeight: 50, alignment: .leading)
                    HStack {
                        NumberCircleView(number: 3)
                        Text("When you're ready to speak, tap the \"Speak\" button. The system will start recording your speech after a countdown.")
                            .font(Font.custom("SF Pro", size: 16))
                            .foregroundColor(.black)
                    } .frame(maxWidth: 300, maxHeight: 100, alignment: .leading)
                    HStack {
                        NumberCircleView(number: 4)
                        Text("Be aware of the timer at the top of the screen to manage your time effectively.")
                            .font(Font.custom("SF Pro", size: 16))
                            .foregroundColor(.black)
                    } .frame(maxWidth: 300, maxHeight: 80, alignment: .leading)
                
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 185.95615, height: 100)
                        .background(Image("parrot guide resizer")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame( height:120)
                            .offset(y: 30))
                    
                } .padding()
            }
            
            HStack(alignment: .center, spacing: 8) {
                Text("Okay")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    }
            
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(width: 336, height: 62, alignment: .center)
            .background(Constants.Blue)
            .cornerRadius(8)
            .fullScreenCover(isPresented: $isPrepShown, content: {
                SpeechPreparationView(isPrepShown: $isPrepShown)
            })
            .onTapGesture {
                isPrepShown.toggle()
            }
            Spacer().frame(height:90)
        }
    }
}

#Preview {
    GuidelineView(isGuideShown: .constant(false))
}
