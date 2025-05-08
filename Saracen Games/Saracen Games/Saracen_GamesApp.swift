import SwiftUI

@main
struct Saracen_GamesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            SaracenRootView()
                .preferredColorScheme(.light)
        }
    }
}
