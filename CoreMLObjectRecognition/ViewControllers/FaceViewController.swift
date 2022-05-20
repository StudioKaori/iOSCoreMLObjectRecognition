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

        // Do any additional setup after loading the view.
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
