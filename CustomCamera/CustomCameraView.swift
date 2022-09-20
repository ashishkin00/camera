import SwiftUI
import AVFoundation

struct CustomCameraView: View {
    
    @StateObject var model = CustomCameraViewModel()
    var body: some View {
        Image(uiImage: model.image)
            .ignoresSafeArea()
            .onAppear() {
                model.begin()
            }
    }
}
