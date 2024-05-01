import SwiftUI

extension Color {
    static let gold = Color(red: 255/255, green: 215/255, blue: 0/255)
}

struct ContentView: View {
    @State private var showPicker = true

    var body: some View {
        VStack {
            if showPicker {
                LottoPickerView(resetSelection: {
                    self.showPicker = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showPicker = true
                    }
                })
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            if gesture.translation.height > 100 {
                                self.showPicker = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.showPicker = true
                                }
                            }
                        }
                )
            } else {
                Text("App Resetting...")
                    .padding()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.showPicker = true
                        }
                    }
            }
        }
    }
}

struct LottoPickerView: View {
    @State private var randomNumber: Int?
    @State private var firstRowNumbers: [Int] = []
    @State private var secondRowNumbers: [Int] = []
    @State private var isTimerRunning = true
    var resetSelection: () -> Void

    var body: some View {
        VStack {
            Text("Tap anywhere to select a number, pull down to reset")
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
            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
                guard isTimerRunning else { timer.invalidate(); return }
                if firstRowNumbers.count < 5 {
                    randomNumber = generateUniqueRandomNumber(excluding: firstRowNumbers, upperBound: 49)
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

    private func pickNumber() {
        guard let number = randomNumber else { return }
        if firstRowNumbers.count < 5 {
            selectNumber(number, addTo: &firstRowNumbers)
        } else if secondRowNumbers.count < 2 {
            selectNumber(number, addTo: &secondRowNumbers)
        }
    }

    private func selectNumber(_ number: Int, addTo array: inout [Int]) {
        if !array.contains(number) {
            array.append(number)
        }
    }

    private func generateUniqueRandomNumber(excluding array: [Int], upperBound: Int) -> Int {
        var randomNumber: Int
        repeat { randomNumber = Int.random(in: 1...upperBound) } while array.contains(randomNumber)
        return randomNumber
    }
}

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
    }
}

#Preview {
    ContentView()
}
