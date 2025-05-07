//
//  CardView.swift
//  Saracen Games
//
//  Created by Dias Atudinov on 07.05.2025.
//


import SwiftUI

struct SaracenCardView: View {
    let card: Card

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
    SaracenCardView(card: Card(type: "cardFace1SG"))
}
