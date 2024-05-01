import SwiftUI

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
            Text("Tap anywhere to select a number")
                .padding()
            Spacer()
            Text(self.randomNumber != nil ? "\(self.randomNumber!)" : "")
                .font(.system(size: 100))
                .onTapGesture {
                    self.pickNumber()
                }
            Spacer()
            HStack {
                ForEach(self.firstRowNumbers, id: \.self) { number in
                    Text("\(number)")
                        .font(.title)
                        .padding()
                }
            }
            HStack {
                ForEach(self.secondRowNumbers, id: \.self) { number in
                    Text("\(number)")
                        .font(.title)
                        .padding()
                }
            }
            Spacer()
            Button(action: {
                self.resetSelection()
            }) {
                Text("Reset")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .onAppear {
            // Start the timer
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                guard self.isTimerRunning else {
                    timer.invalidate()
                    return
                }
                // Generate random number
                if self.firstRowNumbers.count < 5 {
                    self.randomNumber = self.generateUniqueRandomNumber(excluding: self.firstRowNumbers, upperBound: 49)
                } else if self.secondRowNumbers.count < 2 {
                    self.randomNumber = self.generateUniqueRandomNumber(excluding: self.secondRowNumbers, upperBound: 12)
                } else {
                    self.isTimerRunning = false
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.pickNumber()
        }
    }

    private func pickNumber() {
        if let number = self.randomNumber {
            if self.firstRowNumbers.count < 5 {
                self.selectNumber(number, addTo: &self.firstRowNumbers)
            } else if self.secondRowNumbers.count < 2 {
                self.selectNumber(number, addTo: &self.secondRowNumbers)
            }
        }
    }

    private func selectNumber(_ number: Int, addTo array: inout [Int]) {
        if !array.contains(number) {
            array.append(number)
        }
    }

    private func generateUniqueRandomNumber(excluding array: [Int], upperBound: Int) -> Int {
        var randomNumber: Int
        repeat {
            randomNumber = Int.random(in: 1...upperBound)
        } while array.contains(randomNumber)
        return randomNumber
    }
}







#Preview {
    ContentView()
}
