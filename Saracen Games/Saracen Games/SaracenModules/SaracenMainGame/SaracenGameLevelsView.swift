import SwiftUI

struct SaracenGameLevelsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shopVM: SaracenStoreViewModel

    @State var openGame = false
    @State var selectedIndex = 0
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        CoinBgSaracen()
                        Spacer()
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
                ZStack {
                    Image(.levelSelectBgSaracen)
                        .resizable()
                        .scaledToFit()
                        
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(Range(0...9)) { index in
                            ZStack {
                                Image(.numBgSaracen)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 134:67)
                                
                                Text("\(index + 1)")
                                    .font(.system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 80:40, weight: .black))
                                    .foregroundStyle(.main)
                            }
                            .onTapGesture {
                                selectedIndex = index
                                DispatchQueue.main.async {
                                    openGame = true
                                }
                                
                            }
                        }
                    }.frame(width: SaracenDeviceInfo.shared.deviceType == .pad ? 582:301)
                }.frame(width: SaracenDeviceInfo.shared.deviceType == .pad ? 582:351)
                Spacer()
            }
        }.background(
            ZStack {
                Image(.menuBgSaracen)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $openGame) {
            GameView(shopVM: shopVM, level: selectedIndex)
        }
    }
}

#Preview {
    SaracenGameLevelsView(shopVM: SaracenStoreViewModel())
}
