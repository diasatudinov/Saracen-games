import SwiftUI

struct             SaracenRepeatSequenceGameView: View {
    @StateObject var user = SGUser.shared
    @Environment(\.presentationMode) var presentationMode
    
    // Names of the images in your Assets catalog
    let cardImages = ["cardFace1Saracen", "cardFace2Saracen", "cardFace3Saracen", "cardFace4Saracen", "cardFace5Saracen", "cardFace6Saracen"]
    let sequenceLength = 3
    
    // Game state
    @State private var sequence: [Int] = []
    @State private var currentStep: Int? = nil
    @State private var gamePhase: GamePhase = .showing
    @State private var userInputIndex = 0
    @State private var feedback: String? = nil
    
    enum GamePhase {
        case showing
        case userTurn
        case finished
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        HStack(alignment: .top) {
                            
                            Button {
                                startGame()
                                
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
                        
                    }
                }
                
                Spacer()
                
                if gamePhase == .showing {
                    if let idx = currentStep {
                        MemorizationCardView(imageName: cardImages[idx])
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 600:300)
                            .padding()
                            .transition(.opacity)
                    }
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                        ForEach(0..<cardImages.count, id: \.self) { index in
                           
                            Button {
                                handleTap(on: index)
                            } label: {
                                MemorizationCardView(imageName: cardImages[index])
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                
            }
            
            if gamePhase == .finished {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                if userInputIndex >= sequenceLength {
                    ZStack(alignment: .bottom) {
                        Image(.coupleGameWinBgSaracen)
                            .resizable()
                            .scaledToFit()
                            
                        Button {
                            startGame()
                            
                        } label: {
                            Image(.restartIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 130:65)
                        }.offset(y: 20)
                        
                    }.frame(height:  SGDeviceManager.shared.deviceType == .pad ? 878:439)
                } else {
                    ZStack(alignment: .bottom) {
                        Image(.repeatGameLoseBgSaracen)
                            .resizable()
                            .scaledToFit()
                        
                        Button {
                            startGame()
                            
                        } label: {
                            Image(.restartIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 130:65)
                        }.offset(y: 20)
                        
                    }.frame(height:  SGDeviceManager.shared.deviceType == .pad ? 878:439)
                }
            }
        }
        .background(
            ZStack {
                Image(.miniGameBgSaracen)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .onAppear {
            startGame()
        }
        .animation(.easeInOut, value: currentStep)
    }
    
    private var headerText: String {
        switch gamePhase {
        case .showing:
            return "Watch the sequence..."
        case .userTurn:
            return "Your turn: repeat the sequence"
        case .finished:
            return feedback ?? ""
        }
    }
    
    private func startGame() {
        sequence = Array(0..<cardImages.count).shuffled().prefix(sequenceLength).map { $0 }
        userInputIndex = 0
        feedback = nil
        gamePhase = .showing
        currentStep = nil
        
        Task {
            await revealSequence()
        }
    }
    
    @MainActor
    private func revealSequence() async {
        for idx in sequence {
            currentStep = idx
            try? await Task.sleep(nanoseconds: 800_000_000)
            currentStep = nil
            try? await Task.sleep(nanoseconds: 300_000_000)
        }
        gamePhase = .userTurn
    }
    
    private func handleTap(on index: Int) {
        guard gamePhase == .userTurn else { return }
        if index == sequence[userInputIndex] {
            userInputIndex += 1
            if userInputIndex >= sequenceLength {
                feedback = "Correct! You win!"
                user.updateUserMoney(for: 30)
                gamePhase = .finished
                
            }
        } else {
            feedback = "Wrong! Try again."
            gamePhase = .finished
        }
    }
}

struct MemorizationCardView: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .cornerRadius(8)
            .shadow(radius: 4)
    }
}

#Preview {
                SaracenRepeatSequenceGameView()
}
