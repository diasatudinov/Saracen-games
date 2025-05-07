import SwiftUI

struct SaracenGuessNumberGame: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var target = Int.random(in: 100...999)
    @State private var guessDigits: [String] = []
    @State private var feedback: String = ""
    @State private var attempts = 0
    
    private let padNumbers = [1, 2, 3,
                              4, 5, 6,
                              7, 8, 9,
                              0]
    

        var body: some View {
            ZStack {
                VStack(spacing: SGDeviceManager.shared.deviceType == .pad ? 40:20) {

                    HStack(alignment: .top) {
                        
                        Button {
                            resetGame()
                            
                        } label: {
                            Image(.restartIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 160:80)
                        }
                        
                        Spacer()
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.homeIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 150:75)
                        }
                    }.padding([.horizontal, .top])

                    ZStack {
                        Image(.gameTextBgSaracen)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 110:55)
                        
                        Text("GUESS THE NUMBER")
                            .font(.system(size: SGDeviceManager.shared.deviceType == .pad ? 48:24, weight: .black))
                            .foregroundStyle(.white)
                        
                    }

                    HStack(spacing: 16) {
                        ForEach(0..<3) { idx in
                            ZStack {
                                Image(.numBgSaracen)
                                    .resizable()
                                    .scaledToFit()
                                
                                TextWithBorderSaracen(text: idx < guessDigits.count ? guessDigits[idx] : "" , font: .system(size: 36, weight: .bold), textColor: .white, borderColor: .main, borderWidth: 1)
                                
                                
                            }.frame(width: SGDeviceManager.shared.deviceType == .pad ? 150:100, height: SGDeviceManager.shared.deviceType == .pad ? 150:100)
                        }
                    }
                    .padding(.vertical)


                    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
                    LazyVGrid(columns: columns, spacing: SGDeviceManager.shared.deviceType == .pad ? 24:12) {
                        ForEach(padNumbers, id: \ .self) { num in
                            Button(action: { numberPressed(num) }) {
                                ZStack {
                                    Image(.keyBoardBtnSaracen)
                                        .resizable()
                                        .scaledToFit()
                                    Text("\(num)")
                                        .font(.system(size: SGDeviceManager.shared.deviceType == .pad ? 96:48, weight: .bold))
                                        .foregroundColor(.white)
                                }.frame(width: SGDeviceManager.shared.deviceType == .pad ? 150:100, height: SGDeviceManager.shared.deviceType == .pad ? 150:100)
                            }
                            .disabled(guessDigits.count >= 3)
                        }
                    }.frame(width: SGDeviceManager.shared.deviceType == .pad ? 500:350)
                    .padding(.horizontal)

                    Spacer()
                }
                
                if !feedback.isEmpty {
                    Text(feedback)
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 10)
                        .shadow(radius: 2)
                    
                    
                        if Int(guessDigits.joined()) ?? 0 < target {
                            ZStack {
                                Image(.guessNumBgSaracen)
                                    .resizable()
                                    .scaledToFit()
                                
                                TextWithBorderSaracen(text: "INCORRECT,\n GUESS Higher!", font: .system(size: 34, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                    .multilineTextAlignment(.center)
                                    .textCase(.uppercase)
                            }.frame(height:  SGDeviceManager.shared.deviceType == .pad ? 878:439)
                            
                        } else if Int(guessDigits.joined()) ?? 0 > target{
                            ZStack {
                                Image(.guessNumBgSaracen)
                                    .resizable()
                                    .scaledToFit()
                                TextWithBorderSaracen(text: "INCORRECT,\n GUESS LOWER!", font: .system(size: 34, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                    .multilineTextAlignment(.center)
                               
                            }.frame(height:  SGDeviceManager.shared.deviceType == .pad ? 878:439)
                            
                        } else {
                            ZStack(alignment: .bottom) {
                                Image(.coupleGameWinBgSaracen)
                                    .resizable()
                                    .scaledToFit()
                                    
                                    
                                Button {
                                    resetGame()
                                    
                                } label: {
                                    Image(.restartIconSaracen)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: SGDeviceManager.shared.deviceType == .pad ? 130:65)
                                }.offset(y: 20)
                                
                            }.frame(height:  SGDeviceManager.shared.deviceType == .pad ? 878:439)
                            
                        }
                    
                    
                }
            }.background(
                ZStack {
                    Image(.miniGameBgSaracen)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                }
            )
        }

    private func numberPressed(_ num: Int) {
        guard guessDigits.count < 3 else { return }
        guessDigits.append("\(num)")
        if guessDigits.count == 3 {
            evaluateGuess()
        }
    }

    private func evaluateGuess() {
        let guess = Int(guessDigits.joined()) ?? 0
        attempts += 1
        if guess < target {
            feedback = "Too low!"
        } else if guess > target {
            feedback = "Too high!"
        } else {
            feedback = "You got it in \(attempts) tries!"
            SGUser.shared.updateUserMoney(for: 20)
        }
        if feedback.starts(with: "You got it") {
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                guessDigits = []
                feedback = ""
            }
        }
    }

    private func resetGame() {
        target = Int.random(in: 100...999)
        guessDigits = []
        feedback = ""
        attempts = 0
    }
}

#Preview {
    SaracenGuessNumberGame()
}

