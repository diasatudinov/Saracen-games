import SwiftUI

struct SaracenOptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settingsVM: OptionsViewModelSaracen
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
                
                Spacer()
                
                ZStack {
                    Image(.optionsBgSaracen)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        TextWithBorderSaracen(text: "SOUND", font: .system(size: 23, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                        
                       
                            
                            Image(settingsVM.soundEnabled ? .onSaracen:.offSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 70:35)
                                .onTapGesture {
                                    withAnimation {
                                        settingsVM.soundEnabled.toggle()
                                    }
                                }
                        
                        TextWithBorderSaracen(text: "MUSIC", font: .system(size: 23, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                        
                        
                            Image(settingsVM.musicEnabled ? .onSaracen:.offSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 70:35)
                                .onTapGesture {
                                    withAnimation {
                                        settingsVM.musicEnabled.toggle()
                                    }
                                }
                        
                    }
                    
                }.frame(height: 345)
                
                Spacer()
            }.padding(30)
        }.background(
            ZStack {
                Image(.menuBgSaracen)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
}

#Preview {
    SaracenOptionsView(settingsVM: OptionsViewModelSaracen())
}
