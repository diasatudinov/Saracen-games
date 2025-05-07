import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, мир!")
                .font(.custom("Peace Sans Webfont", size: 17))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
