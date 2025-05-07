//
//  GameView.swift
//  Saracen Games
//
//  Created by Dias Atudinov on 07.05.2025.
//


import SwiftUI
import SpriteKit

struct SaracenMainGameView: View {
    @Environment(\.presentationMode) var presentationMode
   
    @State var gameScene: GameScene = {
        let scene = GameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    @State var island1 = 0
    @State var island2 = 0
    @State var island3 = 0
    @State var island4 = 0
    
    @ObservedObject var shopVM: SaracenStoreViewModel
    @State private var powerUse = false
    @State private var isWin = false
    @State private var score = 0
    @State var level: Int
    var imagesForView: [String] = ["viewImage1","viewImage2","viewImage3","viewImage4","viewImage5", ""]
    
    var body: some View {
        ZStack {
            SpriteViewContainer(scene: gameScene, isWin: $isWin, score: $score, level: level)
                .ignoresSafeArea()
            
            VStack(spacing: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100) {
                HStack(spacing: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100) {
                    ZStack {
                        switch island1 {
                        case 0:
                            Image(.island1Saracen)
                                .resizable()
                                .scaledToFit()
                        case 1:
                            Image(.island2Saracen)
                                .resizable()
                                .scaledToFit()
                        case 2:
                            Image(.island3Saracen)
                                .resizable()
                                .scaledToFit()
                        case 3:
                            Image(.island4Saracen)
                                .resizable()
                                .scaledToFit()
                        default:
                            Image(.island1Saracen)
                                .resizable()
                                .scaledToFit()
                        }
                        
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: SaracenDeviceInfo.shared.deviceType == .pad ? 280:140,height: SaracenDeviceInfo.shared.deviceType == .pad ? 400:200)
                    
                    ZStack {
                        switch island2 {
                        case 0:
                            Image(.island1Saracen)
                                .resizable()
                                .scaledToFit()
                        case 1:
                            Image(.island2Saracen)
                                .resizable()
                                .scaledToFit()
                        case 2:
                            Image(.island3Saracen)
                                .resizable()
                                .scaledToFit()
                        case 3:
                            Image(.island4Saracen)
                                .resizable()
                                .scaledToFit()
                        default:
                            Image(.island1Saracen)
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: SaracenDeviceInfo.shared.deviceType == .pad ? 280:140,height: SaracenDeviceInfo.shared.deviceType == .pad ? 400:200)
                }
                
                HStack(spacing: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100) {
                    ZStack {
                        switch island3 {
                        case 0:
                            Image(.island1Saracen)
                                .resizable()
                                .scaledToFit()
                        case 1:
                            Image(.island2Saracen)
                                .resizable()
                                .scaledToFit()
                        case 2:
                            Image(.island3Saracen)
                                .resizable()
                                .scaledToFit()
                        case 3:
                            Image(.island4Saracen)
                                .resizable()
                                .scaledToFit()
                        default:
                            Image(.island1Saracen)
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: SaracenDeviceInfo.shared.deviceType == .pad ? 280: 140,height: SaracenDeviceInfo.shared.deviceType == .pad ? 400:200)
                    
                    ZStack {
                        switch island4 {
                        case 0:
                            Image(.island1Saracen)
                                .resizable()
                                .scaledToFit()
                        case 1:
                            Image(.island2Saracen)
                                .resizable()
                                .scaledToFit()
                        case 2:
                            Image(.island3Saracen)
                                .resizable()
                                .scaledToFit()
                        case 3:
                            Image(.island4Saracen)
                                .resizable()
                                .scaledToFit()
                        default:
                            Image(.island1Saracen)
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: SaracenDeviceInfo.shared.deviceType == .pad ? 280:140,height: SaracenDeviceInfo.shared.deviceType == .pad ? 400:200)
                }
            }
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.homeIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                        }
                        
                        Spacer()
                        Button {
                            gameScene.restartLevel()
                            isWin = false
                            island1 = Int.random(in: Range(0...3))
                            island2 = Int.random(in: Range(0...3))
                            island3 = Int.random(in: Range(0...3))
                            island4 = Int.random(in: Range(0...3))
                        } label: {
                            Image(.restartIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                        }
                    }.padding([.horizontal, .top])
                }
                
                Spacer()
            }
            
            if isWin {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                ZStack(alignment: .bottom) {
                    Image(.coupleGameWinBgSaracen)
                        .resizable()
                        .scaledToFit()
                        
                    Button {
                        gameScene.restartLevel()
                        isWin = false
                        island1 = Int.random(in: Range(0...3))
                        island2 = Int.random(in: Range(0...3))
                        island3 = Int.random(in: Range(0...3))
                        island4 = Int.random(in: Range(0...3))
                    } label: {
                        Image(.restartIconSaracen)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 130:65)
                    }.offset(y: 20)
                    
                }.frame(height:  SaracenDeviceInfo.shared.deviceType == .pad ? 878:439)
            }
            
        }.background(
            ZStack {
                if let item = shopVM.currentBgItem {
                    Image(item.image)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                }
            }
        )
        .onAppear {
            island1 = Int.random(in: Range(0...3))
            island2 = Int.random(in: Range(0...3))
            island3 = Int.random(in: Range(0...3))
            island4 = Int.random(in: Range(0...3))
        }
    }
}

#Preview {
    SaracenMainGameView(shopVM: SaracenStoreViewModel(), level: 0)
}
