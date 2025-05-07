import SwiftUI
import AVFoundation

struct SaracenCoupleGameView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var user = SGUser.shared
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var cards: [SaracenCard] = []
    @State private var selectedCards: [SaracenCard] = []
    @State private var gameEnded: Bool = false
    @State private var isWin: Bool = false
    @State private var pauseShow: Bool = false
    private let cardTypes = ["cardFace1Saracen", "cardFace2Saracen", "cardFace3Saracen", "cardFace4Saracen", "cardFace5Saracen", "cardFace6Saracen"]
    private let gridSize = 4
    
    @State private var counter: Int = 0
    
    @State private var timeLeft: Int = 60
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            
                VStack {
                    HStack {
                        
                        Button {
                            setupGame()
                            
                        } label: {
                            Image(.restartIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 160:80)
                        }
                        
                        Spacer()
                        ZStack {
                            Image(.circleIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 152:76)
                            
                            TextWithBorderSaracen(text: "\(timeLeft)", font: .system(size: SGDeviceManager.shared.deviceType == .pad ? 72:36, weight: .bold), textColor: .white, borderColor: .main, borderWidth: 1)
                            
                        }
                        Spacer()
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.homeIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 160:80)
                        }
                        
                        
                    }.padding()
                    Spacer()
                    VStack(spacing: SGDeviceManager.shared.deviceType == .pad ? -40:-20) {
                        ZStack {
                            Image(.gameTextBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 110:55)
                            
                            Text("MATCH THE CARDS")
                                .font(.system(size: SGDeviceManager.shared.deviceType == .pad ? 48:24, weight: .black))
                                .foregroundStyle(.white)
                            
                        }
                        
                       
                    }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                        ForEach(cards) { card in
                            SaracenCardView(card: card)
                                .onTapGesture {
                                    flipCard(card)
                                   
                                }
                                .opacity(card.isMatched ? 0.5 : 1.0)
                        }
                        
                    }
                    .frame(width: SGDeviceManager.shared.deviceType == .pad ? 500:350)
                   Spacer()
                }
                .onAppear {
                    setupGame()
                }
            
            if gameEnded {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                if isWin {
                    ZStack(alignment: .bottom) {
                        Image(.coupleGameWinBgSaracen)
                            .resizable()
                            .scaledToFit()
                            
                        Button {
                            setupGame()
                            
                        } label: {
                            Image(.restartIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 130:65)
                        }.offset(y: 20)
                        
                    }.frame(height:  SGDeviceManager.shared.deviceType == .pad ? 878:439)
                } else {
                    ZStack(alignment: .bottom) {
                        Image(.coupleGameLoseBgSaracen)
                            .resizable()
                            .scaledToFit()
                            
                        Button {
                            setupGame()
                            
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
        .onReceive(timer) { _ in
            guard !gameEnded else { return }
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                gameEnded = true
                isWin = false
                timer.upstream.connect().cancel()
            }
        }
        .background(
            Image(.miniGameBgSaracen)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        
        
    }
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if counter < 4 {
                withAnimation {
                    counter += 1
                }
            }
        }
    }
    
    private func setupGame() {
        // Reset state
        selectedCards.removeAll()
        gameEnded = false
        timeLeft = 60
        // Restart timer
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        // Generate cards
        var gameCards = [SaracenCard]()
        
        // Add 4 cards of each type (24 cards total for 6 types)
        for type in cardTypes {
            gameCards.append(SaracenCard(type: type))
            gameCards.append(SaracenCard(type: type))
        }
                
        // Shuffle cards
        gameCards.shuffle()
        
        // Ensure exactly 25 cards
        cards = Array(gameCards.prefix(gridSize * gridSize))
    }
    
    private func flipCard(_ card: SaracenCard) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isFaceUp,
              !cards[index].isMatched,
              selectedCards.count < 2 else { return }
        
        // Flip card
        cards[index].isFaceUp = true
        selectedCards.append(cards[index])
        
       if selectedCards.count == 2 {
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        let allMatch = selectedCards.allSatisfy { $0.type == selectedCards.first?.type }
        
        if allMatch {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isMatched = true
                }
            }
            isWin = true
        } else {
            isWin = false
        }
        
        // Flip cards back over after a delay if they don't match
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isFaceUp = false
                }
            }
            selectedCards.removeAll()
            
            // Check if all cards are matched
            if cards.allSatisfy({ $0.isMatched || $0.type == "cardSemaphore" }) {
                gameEnded = true
                user.updateUserMoney(for: 30)
            }
        }
    }
}

#Preview {
    SaracenCoupleGameView()
}
