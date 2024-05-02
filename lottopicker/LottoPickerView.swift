import SwiftUI

extension Color {
    static let gold = Color(red: 255/255, green: 215/255, blue: 0/255)
}

struct LottoPickerView: View {
    @State private var randomNumber: Int?
    @State private var firstRowNumbers: [Int] = []
    @State private var secondRowNumbers: [Int] = []
    @State private var isTimerRunning = true
    @State private var TimerDelay = 1.0 // 1 second

    var resetSelection: () -> Void

    var body: some View {
        VStack {
            Text("Tap to select a number, pull down to reset")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Text(randomNumber != nil ? "\(randomNumber!)" : "")
                .font(.system(size: 100))
                .onTapGesture {
                    pickNumber()
                }
            Spacer()
            HStack(spacing: 10) {
                ForEach(firstRowNumbers, id: \.self) { number in
                    LottoBall(number: number, backgroundColor: .black)
                }
            }
            HStack(spacing: 10) {
                ForEach(secondRowNumbers, id: \.self) { number in
                    LottoBall(number: number, backgroundColor: .gold)
                }
            }
            Spacer()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: TimerDelay, repeats: true) { timer in
                guard isTimerRunning else { timer.invalidate(); return }
                if firstRowNumbers.count < 5 {
                    randomNumber = generateUniqueRandomNumber(excluding: firstRowNumbers, upperBound: 50)
                } else if secondRowNumbers.count < 2 {
                    randomNumber = generateUniqueRandomNumber(excluding: secondRowNumbers, upperBound: 12)
                } else {
                    isTimerRunning = false
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            pickNumber()
        }
    }

    public func pickNumber() {
        guard let number = randomNumber else { return }
        if firstRowNumbers.count < 5 {
            selectNumber(number, addTo: &firstRowNumbers)
        } else if secondRowNumbers.count < 2 {
            selectNumber(number, addTo: &secondRowNumbers)
        }
    }

    public func selectNumber(_ number: Int, addTo array: inout [Int]) {
        if !array.contains(number) {
            array.append(number)
        }
    }

    public func generateUniqueRandomNumber(excluding array: [Int], upperBound: Int) -> Int {
        var randomNumber: Int
        repeat { randomNumber = Int.random(in: 1...upperBound) } while array.contains(randomNumber)
        return randomNumber
    }
}
