import SwiftUI
import SpriteKit

struct SaracenMazeGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isWin = false
    @State private var gameScene: SaracenMazeScene = {
        let scene = SaracenMazeScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    @State private var powerUse = false
    
    var body: some View {
        ZStack {
            SaracenMazeViewContainer(scene: gameScene, isWin: $isWin)
                
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        
                        Button {
                            gameScene.restartGame()
                            isWin = false
                        } label: {
                            Image(.restartIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 130:65)
                        }
                        Spacer()
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.homeIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 130:65)
                        }

                    }.padding([.horizontal, .top])
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    Button {
                        gameScene.moveUp()
                        
                    } label: {
                        Image(.controlArrowSaracen)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                    }
                    HStack(spacing: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50) {
                        Button {
                            gameScene.moveLeft()
                        } label: {
                            Image(.controlArrowSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                                .rotationEffect(.degrees(90))
                                .scaleEffect(x: -1, y: 1)
                        }
                        
                        Button {
                            gameScene.moveRight()
                        } label: {
                            Image(.controlArrowSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                                .rotationEffect(.degrees(90))
                        }
                    }
                    
                    Button {
                        gameScene.moveDown()
                    } label: {
                        Image(.controlArrowSaracen)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                            .scaleEffect(x: 1, y: -1)
                    }
                }
                
            }
            
            if isWin {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                ZStack(alignment: .bottom) {
                    Image(.coupleGameWinBgSaracen)
                        .resizable()
                        .scaledToFit()
                        
                    Button {
                        
                        gameScene.restartGame()
                        isWin = false
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
                Image(.miniGameBgSaracen)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
}

#Preview {
    SaracenMazeGameView()
}
