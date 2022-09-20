import AVFoundation
import SwiftUI

class CustomCameraViewModel: ObservableObject {
    @Published var captureSession = AVCaptureSession()
    @Published var previewLayer = AVCaptureVideoPreviewLayer()
    @Published var image = UIImage(systemName: "camera")!
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
        
        let diameter: CGFloat = 100
        let rect = CGRect(origin: CGPoint.zero,
                          size: CGSize(width: diameter, height: diameter))
            
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.path = CGPath(ellipseIn: rect,
                                 transform: nil)
                
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        
        image = renderer.image {
            context in

            return shapeLayer.render(in: context.cgContext)
        }
        
        captureSession.commitConfiguration()
        captureSession.startRunning()
    }
}
