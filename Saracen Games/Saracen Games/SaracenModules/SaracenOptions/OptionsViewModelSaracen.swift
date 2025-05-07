import SwiftUI

class OptionsViewModelSaracen: ObservableObject {
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
}
