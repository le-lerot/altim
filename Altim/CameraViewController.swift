//
//  CameraViewController.swift
//  Altim
//
//  Created by Martin Delille on 23/12/2016.
//  Copyright © 2016 Phonations. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?

    @IBOutlet weak var cameraView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetHigh
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

        do {
            let input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)

            // Create video preview layer and add it to the UI
            if let newCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session) {
                let viewLayer = self.cameraView.layer
                newCaptureVideoPreviewLayer.frame = self.cameraView.bounds;

                viewLayer.addSublayer(newCaptureVideoPreviewLayer)

                self.cameraPreviewLayer = newCaptureVideoPreviewLayer;

                session.startRunning()
            }
        } catch {
            print(error)
        }
    }


    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
