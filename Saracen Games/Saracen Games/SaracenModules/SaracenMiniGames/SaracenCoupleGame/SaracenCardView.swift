import SwiftUI

struct SaracenCardView: View {
    let card: SaracenCard

    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                Image(card.type)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 200:120)
            } else {
                Image(.cardBackSaracen)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 200:120)
            }
        }
    }
}

#Preview {
    SaracenCardView(card: SaracenCard(type: "cardFace1SG"))
}
