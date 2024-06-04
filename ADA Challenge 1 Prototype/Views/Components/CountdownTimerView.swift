import SwiftUI
import Combine

struct Constants {
    static let Grey1: Color = Color(red: 0.85, green: 0.85, blue: 0.85)
    static let Black: Color = Color(red: 0.37, green: 0.37, blue: 0.37)
    static let Blue: Color = Color(red: 0.11, green: 0.41, blue: 0.76)
}

struct CountdownTimerView: View {
    let maxTime: TimeInterval // Maximum time in seconds
    let completion: () -> Void // Closure to execute when the countdown ends
    
    @State private var timeRemaining: TimeInterval
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(maxTime: TimeInterval, completion: @escaping () -> Void) {
        self.maxTime = maxTime
        self.completion = completion
        self._timeRemaining = State(initialValue: maxTime)
    }
    
    var body: some View {
        HStack {
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: "timer").padding(.leading).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: CGFloat(228 * (timeRemaining / maxTime)), height: 15)
                    .background(.green)
                    .cornerRadius(35.91663)
                    .padding(.horizontal)
                    .animation(.linear(duration: 1.0))
            }
            .padding(.leading, 0)
            .padding(.trailing, 108.8889)
            .padding(.vertical, 0)
            .frame(width: 300, height: 30, alignment: .leading)
            .background(.white)
            .cornerRadius(35.91663)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 3)
            
            Text(timeString(from: timeRemaining))
                .font(Font.custom("Inter", size: 13))
                .foregroundColor(Constants.Black)
        }.padding(.bottom)
//        .onAppear {
//            startTimer()
//        }
//        .onDisappear {
//            stopTimer()
//        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                completion()
            }
        }
    }
    
    private func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerView(maxTime: 180) {
            print("Countdown finished!")
        }
        .previewLayout(.sizeThatFits)
        
    }
}


