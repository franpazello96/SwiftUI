import SwiftUI

@main
struct SwiftUIObrasApp: App {
    @StateObject private var galeriaState = GaleriaState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(galeriaState)
        }
    }
}
