//
//  GradeBox.swift
//  ADA Challenge 1 Prototype
//
//  Created by tandyys on 03/04/24.
//

import SwiftUI

struct GradeBox: View {
    let boxColor: Color = Color(red: 0.11, green: 0.41, blue: 0.76)
    let gradeScore: String
    
    var body: some View {
        ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 70, height: 70)
              .background(boxColor)
          .cornerRadius(7.17969)
            Text("\(gradeScore)")
                .foregroundColor(.white)
                .font(.system(size: 48))
                .bold()
        }
    }
}

#Preview {
    GradeBox(gradeScore: "A")
}
