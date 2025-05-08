import SwiftUI

class Links {
    
    static let shared = Links()
    
    static let winStarData = "https://saracagame.top/start"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
