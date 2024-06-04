//
//  PromptCard.swift
//  ADA Challenge 1 Prototype
//
//  Created by Rio Ikhsan on 02/04/24.
//

import SwiftUI
struct PromptCard : View {
    let prompt: String
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                // Prompt Card
                VStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 335, height: 137)
                        .background(.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
                        .overlay(
                            
                            
                            Text(prompt)
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(maxWidth: 400)
                            
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .inset(by: 0.5)
                                .stroke(.gray, lineWidth: 1)
                        )
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 106, height: 31)
                        .background(.yellow)
                        .cornerRadius(20)
                        .overlay(
                            Text("Prompt")
                                .font(.system(size: 14, weight: .bold, design: .default))
                                .foregroundColor(Constants.Blue)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: 0.5)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .offset(y: -160)
                }
                
                // Prompt Card

                Spacer()
            }
        }
    }
}

#Preview {
    PromptCard(prompt: "")
}
