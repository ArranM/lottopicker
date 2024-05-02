import SwiftUI
import SwiftUI

struct LottoBall: View {
    var number: Int
    var backgroundColor: Color
    
    var body: some View {
        Text("\(number)")
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(backgroundColor)
            .clipShape(Circle())
            .padding()
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}