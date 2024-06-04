//
//  NumberCircleView.swift
//  ADA Challenge 1 Prototype
//
//  Created by Rio Ikhsan on 03/04/24.
//

import SwiftUI

struct NumberCircleView: View {
    let number: Int
    let circleSize: CGFloat = 28.0
    let circleColor: Color = Color(red: 0.11, green: 0.41, blue: 0.76)
    let textColor: Color = .white
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(circleColor)
                .frame(width: circleSize, height: circleSize)
            
            Text("\(number)")
                .foregroundColor(textColor)
                .font(.headline)
        }
    }
}

#Preview {
    NumberCircleView(number: 1)
}
