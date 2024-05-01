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

#Preview {
    ContentView()
}
