//
//  FaceViewController.swift
//  CoreMLObjectRecognition
//
//  Created by Kaori Persson on 2022-05-20.
//

import UIKit
import AVFoundation // video input output framework
import Vision // Vision import

class FaceViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    var recognitionInterval = 0 //Interval for object recognition
    
    var mlModel: VNCoreMLModel? // CoreML model
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setting for video
        setVideo()
        setModel()
    }
    
    func setVideo() {
        
        // Session settings
        let session = AVCaptureSession() // AVCaptureSettion: managing video session
        session.sessionPreset = AVCaptureSession.Preset.photo // Quality of the image
        
        // video input settings
        let device = AVCaptureDevice.default(for: .video) // get device
        guard let input = try? AVCaptureDeviceInput(device: device!) else { return } // create input by using device
        if session.canAddInput(input) { // if the input can be addable, add the input to the session
            session.addInput(input)
        }
        
        // Output settings
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoQueue")) // set delegate to receive the data every frame
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        
        // Preview layer setting
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Resize setting, set aspect fill
        previewLayer.frame = view.bounds // the same size as view
        view.layer.insertSublayer(previewLayer, at: 0)
        
        // Start
        session.startRunning()
    }
    
    func setModel() {
        
        // create instance, model property
        mlModel = try? VNCoreMLModel(for: AgeNet().model)
    }
    
    // caputureOutput will be called for each frame was written
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        // Recognise the object every 20 frames
        if recognitionInterval < 20 {
            recognitionInterval += 1
            return
        }
        recognitionInterval = 0
        
        
        // Convert CMSampleBuffer(an object holding media data) to CMSampleBufferGetImageBuffer
        guard
            let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer),
            let model = mlModel // Unwrap the mlModel
        else { return }
        
        // Create image process request, pass model and result
        let request = VNCoreMLRequest(model: model) { //An image analysis request that uses a Core ML model to process images.

            (request: VNRequest, error: Error?) in
            
            // Get results as VNClassificationObservation array
            guard let results = request.results as? [VNClassificationObservation] else { return }
            
            // top 5 results
            var displayText = ""
            for result in results.prefix(5) {
                displayText += "\(Int(result.confidence * 100))%" + result.identifier + "\n"
            }
            
            // Execute it in the main thread
            DispatchQueue.main.async {
                self.textView.text = displayText
            }
        }
        
        // Execute the request
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
