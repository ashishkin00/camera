import AVFoundation
import SwiftUI

class CustomCameraViewModel: ObservableObject {
    @Published var captureSession = AVCaptureSession()
    @Published var previewLayer = AVCaptureVideoPreviewLayer()
    func begin() {
        captureSession.beginConfiguration()
        
        if captureSession.canSetSessionPreset(.photo) {
            captureSession.sessionPreset = .photo
        }
        
        captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
        
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        if let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!) {
            debugPrint("Created video device: ", videoDevice)
            if captureSession.canAddInput(videoDeviceInput) {
                debugPrint("Added video input: ", videoDeviceInput)
                captureSession.addInput(videoDeviceInput)
            }
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspect
        previewLayer.frame = UIScreen.main.bounds
        
        captureSession.commitConfiguration()
        captureSession.startRunning()
    }
}
