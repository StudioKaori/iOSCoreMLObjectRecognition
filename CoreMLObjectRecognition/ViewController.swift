//
//  ViewController.swift
//  CoreMLObjectRecognition
//
//  Created by Kaori Persson on 2022-05-19.
//

import UIKit
import AVFoundation // video input output framework
import Vision // Vision import

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // AVCaptureVideoDataOutputSampleBufferDelegate // when you want to handle the video input every second, you will add the delegate
    
    var recognitionInterval = 8 //Interval for object recognition
    
    var mlModel: VNCoreMLModel? // CoreML model
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial setting for video
        setVideo()
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
    }
}

