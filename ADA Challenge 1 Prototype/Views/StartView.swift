//
//  Start.swift
//  ADA Challenge 1 Prototype
//
//  Created by Ryan Kusnadi on 31/03/24.
//

import SwiftUI

struct Start: View {
    
    @State var isGuideShown = false
    
    struct Constants {
        static let Blue: Color = Color(red: 0.11, green: 0.41,
                                       blue: 0.76)
        static let White: Color = .white
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer().frame(height: 150)
                
                //Mic It Right! Logo
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 320, height: 150)
                    .background(Image("AppLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit))
                
                Spacer().frame(height: 15)
                
                //Sentence below Mic It Right! text
                Text("Sharpen your structured speaking skills through prompt-based practice.")
                    .font(Font.custom("SF Pro", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.White)
                    .frame(width: 320, height: 45, alignment: .top)
                
                Spacer().frame(height: 106)
                
                
                VStack (spacing: 0) {
                    //Parrot image
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 185.95615, height: 172)
                        .background(Image("yellow parrot")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400, height: 240)
                            .offset(y: 11))
                    
                    // Button "Get Prompted"
                    HStack(alignment: .center, spacing: 8) {
                        Text("Get Prompted")
                            .font(Font.custom("Inter-Bold", size: 16))
                            .foregroundColor(Constants.Blue)
                            
                    }
                    
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .frame(width: 193, height: 45, alignment: .center)
                    .background(Constants.White)
                    .cornerRadius(6)
                    .fullScreenCover(isPresented: $isGuideShown, content: {
                        GuidelineView(isGuideShown: $isGuideShown)
                    })
                    .onTapGesture {
                        isGuideShown.toggle()
                    }
                }
                
                Spacer().frame(height: 30)
                
                //info below button
                Text("The prompts are randomly generated to help you develop good and structured responses over time by encouraging spontaneity.")
                    .font(
                        Font.custom("Inter-Regular", size: 9)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.White)
                    .frame(width: 319, height: 30, alignment: .top)
                
                Spacer().frame(height: 200)
                
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 134, height: 5)
                        .background(Constants.White)
                        .cornerRadius(100)
                }
                .padding(.leading, 130)
                .padding(.trailing, 129)
                .padding(.top, 21)
                .padding(.bottom, 8)
                .frame(width: 393, height: 34, alignment: .center)
                .background(Constants.Blue)
                
            }
            .frame(width: 393, height: 852)
            .background(Constants.Blue)
            .navigationBarBackButtonHidden(true)
            
        }
    }
}

#Preview {
    Start()
}
