import SwiftUI

struct SaracenMiniGamesChooseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var game1 = false
    @State private var game2 = false
    @State private var game3 = false
    @State private var game4 = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    CoinBgSaracen()
                    Spacer()
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.homeIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 150:75)
                        }
                        
                    }.padding([.horizontal, .top])
                }
                Spacer()
                VStack {
                    Button {
                        game1 = true
                    } label: {
                       
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "GUESS THE NUMBER", font: .system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 40:20, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                
                                .textCase(.uppercase)
                            
                                
                        }
                    }
                    
                    Button {
                        game2 = true
                    } label: {
                       
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "MATCH THE CARDS", font: .system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 40:20, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                
                                .textCase(.uppercase)
                            
                                
                        }
                    }
                    
                    Button {
                        game3 = true
                    } label: {
                      
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "SIMON SAYS", font: .system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 40:20, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                
                                .textCase(.uppercase)
                            
                                
                        }
                    }
                    
                    Button {
                        game4 = true
                    } label: {
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "MAZE CHALLENGE", font: .system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 40:20, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                
                                .textCase(.uppercase)
                            
                                
                        }
                          
                    }
                }
                
                Spacer()
                
            }.padding()
        }.background(
            ZStack {
                Image(.menuBgSaracen)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $game1) {
            SaracenGuessNumberGame()
        }
        .fullScreenCover(isPresented: $game2) {
            SaracenCoupleGameView()
        }
        .fullScreenCover(isPresented: $game3) {
            SaracenRepeatSequenceGameView()
        }
        .fullScreenCover(isPresented: $game4) {
              SaracenMazeGameView()
        }
    }
}

#Preview {
    SaracenMiniGamesChooseView()
}
