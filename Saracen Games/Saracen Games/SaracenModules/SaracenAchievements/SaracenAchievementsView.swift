import SwiftUI

struct SaracenAchievementsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AchievementsViewModelSaracen

    var body: some View {
        ZStack {
            
            VStack {
                
                HStack(alignment: .top) {
                    CoinBgSaracen()
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Image(.homeIconSaracen)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 130:65)
                    }
                    
                }
                
                
                VStack(alignment: .leading) {
                    ForEach(viewModel.achievements) { achievement in
                        VStack(alignment: .leading) {
                            HStack {
                                
                                TextWithBorderSaracen(text: "\(achievement.num)", font: .system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 54:27, weight: .black), textColor: .main, borderColor: .white, borderWidth: 1)
                                
                                TextWithBorderSaracen(text: "\(achievement.name)", font: .system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 30:19, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                    .textCase(.uppercase)
                                
                            }
                            
                            HStack {
                                Spacer()
                                if achievement.isAchieved {
                                    Image(.dollarIconSaracen)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 108:54)
                                    
                                    ZStack {
                                        Image(.moneyBgSaracen)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 72:36)
                                        
                                        Text("+10")
                                            .font(.system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 50:25, weight: .black))
                                            .foregroundStyle(.white)
                                    }
                                } else {
                                    ZStack {
                                        
                                        Image(.dollarIconSaracen)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 108:54)
                                            .overlay {
                                                Color.black.opacity(0.5)
                                                    .cornerRadius(4)
                                            }
                                        
                                        Image(.lockSaracen)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 80:40)
                                    }
                                    ZStack {
                                        Image(.moneyBgSaracen)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 72:36)
                                            .overlay {
                                                Color.black.opacity(0.5)
                                                    .cornerRadius(4)
                                            }
                                        
                                        TextWithBorderSaracen(text: "+10", font: .system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 50:25, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                                            .textCase(.uppercase)
                                    }
                                }
                                Spacer()
                            }.onTapGesture {
                                viewModel.achieveToggle(achievement)
                            }
                            
                        }
                    }
                }
                
                Spacer()
            }.padding(30)
        }.background(
            ZStack {
               
                Image(.menuBgSaracen)
                    .resizable()
                    
                Color.black.opacity(0.5)
            }.edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    SaracenAchievementsView(viewModel: AchievementsViewModelSaracen())
}
