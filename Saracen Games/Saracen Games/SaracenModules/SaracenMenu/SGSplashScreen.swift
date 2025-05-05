import SwiftUI

struct SGSplashScreen: View {
    @State private var scale: CGFloat = 1.0
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    var body: some View {
        ZStack {
            Image(.gameBgSG)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {

                ZStack {
                    Image(.logoIconSG)
                        .resizable()
                        .scaledToFit()
                    
                    
                }
                .frame(height: 200)
                .padding(.top, 70)
                
                Image(.subtitleImgSG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 82)
                    .padding(.top, 100)
                
               
                
                ZStack {
                   
                    Image(.loaderIconSG)
                        .resizable()
                        .scaledToFit()
                        .colorMultiply(.gray)
                    
                    Image(.loaderIconSG)
                        .resizable()
                        .scaledToFit()
                        .mask(
                            Rectangle()
                                .frame(width: progress * 250)
                                .padding(.trailing, (1 - progress) * 250)
                        )
                    
                }
                .frame(width: 250)
                .padding(.top, 90)
                Spacer()
            }
            
            
        }
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 1 {
                progress += 0.01
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    SGSplashScreen()
}
