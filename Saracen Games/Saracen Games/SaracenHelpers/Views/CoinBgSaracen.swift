import SwiftUI

struct CoinBgSaracen: View {
    @StateObject var user = SGUser.shared
    var body: some View {
        ZStack {
            Image(.moneyViewBgSG)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: SGDeviceManager.shared.deviceType == .pad ? 40:20, weight: .black))
                .foregroundStyle(.white)
                .textCase(.uppercase)
                .offset(x: SGDeviceManager.shared.deviceType == .pad ? 50:25, y: SGDeviceManager.shared.deviceType == .pad ? 2:1)
            
            
            
        }.frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
        
    }
}

#Preview {
    CoinBgSaracen()
}
