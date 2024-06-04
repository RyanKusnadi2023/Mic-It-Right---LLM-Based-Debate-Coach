//
//  FeedbackView.swift
//  ADA Challenge 1 Prototype
//
//  Created by Ryan Kusnadi on 03/04/24.
//

import SwiftUI

struct FeedbackView: View {
    
    let speechText: String 
    let recScore: String
    let asertionFeedback: String
    let reasoningFeedback: String
    let exampleFeedback: String
    let linkingFeedback: String
    
    
    struct Constants {
        static let White: Color = .white
        static let Grey1: Color = Color(red: 0.85, green: 0.85, blue: 0.85)
        static let Black: Color = Color(red: 0.37, green: 0.37, blue: 0.37)
        static let Blue: Color = Color(red: 0.11, green: 0.41, blue: 0.76)
    }
    var body: some View {
        ScrollView {
            
            VStack {
                //kotak putih isi arrow dan title screen diatas
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 393, height: 40)
                    .background(Constants.White)
                    .padding(.top)
                    .overlay(
                        ZStack {
                            Text("Feedback")
                                .font(Font.custom("Inter", size: 16).weight(.semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Constants.Black)
                                .frame(alignment: .center)
                        }
                    )
                
                Divider()
            }
            
            VStack() {
                
                //HEADING
                VStack(alignment: .leading) {
                    HStack {
                        GradeBox(gradeScore: recScore)
                            .padding(.trailing)
                        Text("Potential Improvement")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Constants.Blue)
                            .padding(.bottom)
                    }
                    
                    
                    //SUB HEADING
                    Text("Your Speech")
                        .font(.system(size: 18, weight: .bold))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                .padding()
                //
                
                
                //SPEECH
                HStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 2)
                        .fill(.gray.opacity(0.2))
                        .foregroundColor(.clear)
                        .frame(width: 335, height: 300)
                        .overlay(alignment: .topLeading) {
                            ScrollView { // Added ScrollView
                                VStack(alignment: .leading) {
                                    Text(speechText).padding()
                                }
                            }
                        }
                }
                
                Spacer().frame(height: 20)
                
                //FEEDBACK
                VStack(alignment: .leading) {
                    Text("Feedback")
                        .font(.system(size: 18, weight: .bold)).padding(.bottom)
                    Text("Your feedback is evaluated using the AREL method, which stands for Assertion, Reasoning, Example, and Linkback. It helps you improve your debating skills and make stronger arguments.")
                        .font(.caption)
                }.padding()
                
                
                VStack() {
                    //ASERTION
                    HStack {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(lineWidth: 2)
                            .fill(.gray.opacity(0.2))
                            .foregroundColor(.clear)
                            .frame(width: 335, height:300) // Keep the fixed width
                            .overlay(alignment: .top) {
                                ScrollView { // Added ScrollView
                                    VStack(alignment: .leading) {
                                        HStack {
                                            NumberCircleView(number: 1)
                                            Text("Assertion (A)")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.black)
                                            Spacer()
                                        }.padding()
                                        
                                        Text(asertionFeedback).padding(.leading)
                                    }
                                }.frame(height:300)
                            }
                    }


                    
                    //REASONING
                    HStack {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(lineWidth: 2)
                            .fill(.gray.opacity(0.2))
                            .foregroundColor(.clear)
                            .frame(width: 335, height:300) // Keep the fixed width
                            .overlay(alignment: .top) {
                                ScrollView { // Added ScrollView
                                    VStack(alignment: .leading) {
                                        HStack {
                                            NumberCircleView(number: 2)
                                            Text("Reasoning (R)")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.black)
                                            Spacer()
                                        }.padding()
                                        
                                        Text(reasoningFeedback).padding(.leading)
                                    }
                                }.frame(height:300)
                            }
                    }
                    
                    //EXAMPLE
                    HStack {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(lineWidth: 2)
                            .fill(.gray.opacity(0.2))
                            .foregroundColor(.clear)
                            .frame(width: 335, height:300) // Keep the fixed width
                            .overlay(alignment: .top) {
                                ScrollView { // Added ScrollView
                                    VStack(alignment: .leading) {
                                        HStack {
                                            NumberCircleView(number: 3)
                                            Text("Example (E)")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.black)
                                            Spacer()
                                        }.padding()
                                        
                                        Text(exampleFeedback).padding(.leading)
                                    }
                                }.frame(height:300)
                            }
                    }
                    
                    //LINKBACK
                    HStack {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(lineWidth: 2)
                            .fill(.gray.opacity(0.2))
                            .foregroundColor(.clear)
                            .frame(width: 335, height:300) // Keep the fixed width
                            .overlay(alignment: .top) {
                                ScrollView { // Added ScrollView
                                    VStack(alignment: .leading) {
                                        HStack {
                                            NumberCircleView(number: 4)
                                            Text("Linkback (L)")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.black)
                                            Spacer()
                                        }.padding()
                                        
                                        Text(linkingFeedback).padding(.leading)
                                    }
                                }.frame(height:300)
                            }
                    }
                }
            }.padding()
        } .background(.white)
    }
}

#Preview {
    FeedbackView(speechText: "Test", recScore: "A", asertionFeedback: "Test", reasoningFeedback: "Test", exampleFeedback: "Test", linkingFeedback: "Test")
}
