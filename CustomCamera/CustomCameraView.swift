import SwiftUI
import AVFoundation

struct CustomCameraView: View {
    @StateObject var model = CustomCameraViewModel()
    var body: some View {
        VStack {
        UIPreview(previewLayer: $model.previewLayer)
            .onAppear() {
                model.begin()
            }
            Button("asdasdas")
            {
                model.previewLayer.contents.
            }
        }
    }
}

struct UIPreview: UIViewRepresentable {
    @Binding var previewLayer: AVCaptureVideoPreviewLayer
    func makeUIView(context: Context) -> some UIView {
        UIView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.layer.addSublayer(previewLayer)
    }
}
