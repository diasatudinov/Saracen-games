import SwiftUI

struct SGMenuView: View {
    @State private var showGame = false
    @State private var showShop = false
    @State private var showAchievement = false
    @State private var showMiniGames = false
    @State private var showSettings = false
    
    @StateObject var achievementVM = AchievementsViewModelSaracen()
        @StateObject var settingsVM = OptionsViewModelSaracen()
        @StateObject var shopVM = StoreViewModelSG()
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    CoinBgSaracen()
                    
                    Spacer()
                    
                    Button {
                        showShop = true
                    } label: {
                        Image(.shopIconSaracen)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 130:65)
                    }
                    
                }.padding(.bottom)
                
                Image(.logoIconSG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 320:160)
                    .padding(.bottom)
                
                VStack(spacing: SGDeviceManager.shared.deviceType == .pad ? 80:40) {
                    Button {
                        showGame = true
                        
                    } label: {
                        
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "Play", font: .system(size: SGDeviceManager.shared.deviceType == .pad ? 85:43, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                
                                .textCase(.uppercase)
                            
                                
                        }
                    }
                    
                    
                    Button {
                        showSettings = true
                    } label: {
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "Options", font: .system(size: SGDeviceManager.shared.deviceType == .pad ? 85:43, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                
                                .textCase(.uppercase)
                            
                                
                        }
                    }
                    
                    Button {
                        showMiniGames = true
                    } label: {
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "Mini Games", font: .system(size: SGDeviceManager.shared.deviceType == .pad ? 64:32, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                
                                .textCase(.uppercase)
                            
                                
                        }
                    }
                    
                    Button {
                        showAchievement = true
                    } label: {
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "Achievements", font: .system(size: SGDeviceManager.shared.deviceType == .pad ? 48:24, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                
                                .textCase(.uppercase)
                            
                                
                        }
                    }
                }
                Spacer()
            }.padding(30)
            
            
        }
        .background(
            ZStack {
                Image(.menuBgSaracen)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        //                    .onAppear {
        //                        if settingsVM.musicEnabled {
        //                            GEMusicManager.shared.playBackgroundMusic()
        //                        }
        //                    }
        //                    .onChange(of: settingsVM.musicEnabled) { enabled in
        //                        if enabled {
        //                            GEMusicManager.shared.playBackgroundMusic()
        //                        } else {
        //                            GEMusicManager.shared.stopBackgroundMusic()
        //                        }
        //                    }
        .fullScreenCover(isPresented: $showGame) {
            //            ChooseLevelView(shopVM: shopVM, achievementVM: achievementVM)
        }
        .fullScreenCover(isPresented: $showMiniGames) {
            //            MiniGamesChooseView()
        }
        .fullScreenCover(isPresented: $showAchievement) {
            SaracenAchievementsView(viewModel: achievementVM)
        }
        .fullScreenCover(isPresented: $showShop) {
            SaracenShopView(viewModel: shopVM)
        }
        .fullScreenCover(isPresented: $showSettings) {
            SaracenOptionsView(settingsVM: settingsVM)
        }
        
        
        
        
    }
    
}

#Preview {
    SGMenuView()
}
