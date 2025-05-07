import SwiftUI
import SpriteKit


struct SaracenMazeViewContainer: UIViewRepresentable {
    @StateObject var user = UserSaracen.shared
    var scene: SaracenMazeScene
    @Binding var isWin: Bool
    func makeUIView(context: Context) -> SKView {
        let skView = SKView(frame: UIScreen.main.bounds)
        skView.backgroundColor = .clear
        scene.scaleMode = .resizeFill
        scene.isWinHandler = {
            isWin = true
            user.updateUserMoney(for: 40)
        }
        skView.presentScene(scene)
        
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.frame = UIScreen.main.bounds
    }
}
