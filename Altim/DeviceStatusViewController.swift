//
//  DeviceStatusViewController.swift
//  Altim
//
//  Created by Martin Delille on 23/12/2016.
//  Copyright © 2016 Phonations. All rights reserved.
//

import UIKit
import CoreMotion

class DeviceStatusViewController: UIViewController {

    //MARK: parameters
    @IBOutlet weak var yaw: UILabel!
    @IBOutlet weak var pitch: UILabel!
    @IBOutlet weak var roll: UILabel!
    
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init MotionManager
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (deviceMotion, error) in
            let yawDeg:Double = (deviceMotion?.attitude.yaw)! * 180 / .pi
            self.yaw.text = String(format: "%.2f%", yawDeg) + "°"
            let pitchDeg:Double = (deviceMotion?.attitude.pitch)! * 180 / .pi
            self.pitch.text = String(format: "%.2f%", pitchDeg) + "°"
            let rollDeg:Double = (deviceMotion?.attitude.roll)! * 180 / .pi
            self.roll.text = String(format: "%.2f%", rollDeg) + "°"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

