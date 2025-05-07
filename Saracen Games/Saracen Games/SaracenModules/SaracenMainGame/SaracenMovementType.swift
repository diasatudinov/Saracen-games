import SpriteKit
import SwiftUI

enum SaracenMovementType: Int {
    case straight = 0
    case turnLeft = 1
    case turnRight = 2
    case uTurn = 3
}

struct SaracenShipConfig {
    let name: String
    let initialPosition: CGPoint
    let direction: CGVector
    let movement: SaracenMovementType
}

class SaracenGameScene: SKScene, SKPhysicsContactDelegate {
    var shopVM = SaracenStoreViewModel()
    var levelIndex: Int?
    private var lastTappedShip: SKSpriteNode?
    private var shipArrows: [SKSpriteNode: SKSpriteNode] = [:]
    private var bigArrows: [SKSpriteNode: SKSpriteNode] = [:]
    
    var winHandle: (() -> ())?
    var scoreHandle: (() -> ())?
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        backgroundColor = .clear
        setupLevel(levelIndex ?? 0)
    }
    
    private func setupLevel(_ index: Int) {
        let w = size.width
        let h = size.height
        let fieldHeight = h / 2
        let fieldCenterY = h / 2
        var roadConfigs: [(position: CGPoint, size: CGSize)] = []
        var shipConfigs: [SaracenShipConfig] = []
        
        switch index {
        case 0:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .turnLeft),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: 1), movement: .turnRight),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .straight)
            ]
        case 1:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: 1), movement: .straight),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .turnLeft),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: 1), movement: .turnRight),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: -1, dy: 0), movement: .straight)
            ]
            
        case 2:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: -1), movement: .turnLeft),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .straight),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: -1, dy: 0), movement: .turnLeft)
            ]
            
        case 3:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .turnRight),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: -1, dy: 0), movement: .turnRight)
            ]
            
        case 4:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .turnLeft),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: -1, dy: 0), movement: .turnLeft)
            ]
            
        case 5:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: -1), movement: .turnLeft),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .straight),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: 1), movement: .turnLeft),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .straight)
            ]
            
        case 6:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .turnRight),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: -1, dy: 0), movement: .turnLeft)
            ]
            
        case 7:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .turnRight),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: -1, dy: 0), movement: .turnLeft)
            ]
            
        case 8:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .turnRight),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: -1), movement: .straight),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: -1, dy: 0), movement: .turnRight)
            ]
            
        case 9:
            roadConfigs = [
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: w, height: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100)),
                (CGPoint(x: w/2, y: fieldCenterY), CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 200:100, height: fieldHeight))
            ]
            shipConfigs = [
                SaracenShipConfig(name: "ship0", initialPosition: CGPoint(x: w/2, y: fieldCenterY + fieldHeight/2 - 50), direction: CGVector(dx: 0, dy: 1), movement: .straight),
                SaracenShipConfig(name: "ship1", initialPosition: CGPoint(x: w/2 - fieldHeight/2 + 50, y: fieldCenterY), direction: CGVector(dx: 1, dy: 0), movement: .turnLeft),
                SaracenShipConfig(name: "ship2", initialPosition: CGPoint(x: w/2, y: fieldCenterY - fieldHeight/2 + 50), direction: CGVector(dx: 0, dy: 1), movement: .turnRight),
                SaracenShipConfig(name: "ship3", initialPosition: CGPoint(x: w/2 + fieldHeight/2 - 80, y: fieldCenterY), direction: CGVector(dx: -1, dy: 0), movement: .straight)
            ]
        default:
            break
        }
        
        for config in roadConfigs {
            let road = SKSpriteNode(color: .clear, size: config.size)
            road.position = config.position
            addChild(road)
        }
        guard let item = shopVM.currentPersonItem else { return }
        for shipConfig in shipConfigs {
            let ship = SKSpriteNode(imageNamed: item.image)
            ship.size = CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 192:96, height: SaracenDeviceInfo.shared.deviceType == .pad ? 76:38)
            ship.position = shipConfig.initialPosition
            ship.name = shipConfig.name
            ship.zRotation = atan2(shipConfig.direction.dy, shipConfig.direction.dx)
            ship.userData = [
                "initialPosition": NSValue(cgPoint: shipConfig.initialPosition),
                "direction": NSValue(cgVector: shipConfig.direction),
                "movementType": shipConfig.movement.rawValue
            ]
            ship.physicsBody = SKPhysicsBody(circleOfRadius: SaracenDeviceInfo.shared.deviceType == .pad ? 40:20)
            ship.physicsBody?.categoryBitMask = 0x1 << 0
            ship.physicsBody?.contactTestBitMask = 0x1 << 0
            ship.physicsBody?.collisionBitMask = 0
            ship.physicsBody?.affectedByGravity = false
            addChild(ship)
            
            let arrowTextureName: String
            switch shipConfig.movement {
            case .straight:
                arrowTextureName = "arrowSaracen"
            case .turnLeft:
                arrowTextureName = "arrowLeftSaracen"
            case .turnRight:
                arrowTextureName = "arrowRightSaracen"
            case .uTurn:
                arrowTextureName = "arrowBackSaracen"
            }
            
            let arrow = SKSpriteNode(imageNamed: arrowTextureName)
            arrow.size = CGSize(width: SaracenDeviceInfo.shared.deviceType == .pad ? 40:20, height: SaracenDeviceInfo.shared.deviceType == .pad ? 80:40)
            arrow.position = CGPoint(x: SaracenDeviceInfo.shared.deviceType == .pad ? 40:20, y: 0)
            arrow.zRotation = -(.pi/2)
            ship.addChild(arrow)
            shipArrows[ship] = arrow
        
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        for node in nodes(at: location) {
            if let ship = node as? SKSpriteNode,
               ship.physicsBody?.categoryBitMask == (0x1 << 0) {
                startMovement(for: ship)
                break
            }
        }
    }
    
    private func startMovement(for ship: SKSpriteNode) {
        guard ship.action(forKey: "moving") == nil else { return }
        lastTappedShip = ship
        shipArrows[ship]?.removeFromParent()
        bigArrows[ship]?.removeFromParent()
        
        guard let dVal = ship.userData?["direction"] as? NSValue,
              let tVal = ship.userData?["movementType"] as? NSNumber else { return }
        let dir = dVal.cgVectorValue
        let type = SaracenMovementType(rawValue: tVal.intValue) ?? .straight
        let off: CGFloat = 2000
        var actions: [SKAction] = []
        
        switch type {
        case .straight, .uTurn:
            let rev = (type == .uTurn)
            let dx = rev ? -dir.dx : dir.dx
            let dy = rev ? -dir.dy : dir.dy
            let dest = CGPoint(x: ship.position.x + dx * off,
                               y: ship.position.y + dy * off)
            let move = SKAction.move(to: dest, duration: 3)
            let remove = SKAction.run { [weak self, weak ship] in
                ship?.removeFromParent()
                self?.checkVictory()
            }
            actions = [move, remove]
        case .turnLeft, .turnRight:
            let center = CGPoint(x: size.width/2, y: size.height/2)
            let first = SKAction.move(to: center, duration: 1.5)
            let ang: CGFloat = (type == .turnLeft) ? .pi/2 : -.pi/2
            let rot = SKAction.rotate(byAngle: ang, duration: 0)
            let nd = CGVector(dx: dir.dx * cos(ang) - dir.dy * sin(ang),
                              dy: dir.dx * sin(ang) + dir.dy * cos(ang))
            let dest2 = CGPoint(x: center.x + nd.dx * off,
                                y: center.y + nd.dy * off)
            let second = SKAction.move(to: dest2, duration: 1.5)
            let remove = SKAction.run { [weak self, weak ship] in
                ship?.removeFromParent()
                self?.checkVictory()
            }
            actions = [first, rot, second, remove]
        }
        ship.run(SKAction.sequence(actions), withKey: "moving")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let ship = lastTappedShip else { return }
        if contact.bodyA.node == ship || contact.bodyB.node == ship {
            ship.removeAllActions()
            if let initVal = ship.userData?["initialPosition"] as? NSValue {
                let initPos = initVal.cgPointValue
                ship.run(SKAction.move(to: initPos, duration: 0.5))
            }
            lastTappedShip = nil
        }
    }
    
        private func checkVictory() {
            self.scoreHandle?()
            let remaining = children.reduce(0) { count, node in
                guard let body = node.physicsBody else { return count }
                return body.categoryBitMask == (0x1 << 0) ? count + 1 : count
            }
            if remaining == 0 {
                showVictory()
            }
        }

        private func showVictory() {
            winHandle?()
        }
    
    func restartLevel() {
        removeAllChildren()
        shipArrows.removeAll()
        setupLevel(levelIndex ?? 0)
    }
}
