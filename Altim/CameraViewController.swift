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
                let size = self.cameraView.bounds
                newCaptureVideoPreviewLayer.frame = size;

                viewLayer.addSublayer(newCaptureVideoPreviewLayer)

                self.cameraPreviewLayer = newCaptureVideoPreviewLayer;

                session.startRunning()

                let textLayer = CATextLayer()
                textLayer.string = "coucou"
                textLayer.frame = CGRect(x: 0, y: 20, width: size.width, height: 40)

                viewLayer.addSublayer(textLayer)

                let rectLayer = CALayer()
                rectLayer.backgroundColor = UIColor.red.cgColor
                rectLayer.frame = CGRect(x: size.width / 2 - 20, y: 0, width: 40, height: size.height)

                viewLayer.addSublayer(rectLayer)
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
