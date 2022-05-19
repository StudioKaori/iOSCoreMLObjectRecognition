//
//  YoloViewController.swift
//  CoreMLObjectRecognition
//
//  Created by Kaori Persson on 2022-05-19.
//

import UIKit
import AVFoundation
import Vision

class YoloViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var recognitionInterval = 0
    
    var mlModel: VNCoreMLModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func setVideo() {
 
        
        
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
