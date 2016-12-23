//
//  DeviceStatusViewController.swift
//  Altim
//
//  Created by Martin Delille on 23/12/2016.
//  Copyright © 2016 Phonations. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class DeviceStatusViewController: UIViewController, CLLocationManagerDelegate {

    //MARK: parameters
    @IBOutlet weak var yaw: UILabel!
    @IBOutlet weak var pitch: UILabel!
    @IBOutlet weak var roll: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var altitude: UILabel!
    
    var motionManager = CMMotionManager()
    var locationManager = CLLocationManager()
    
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
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: location manager delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitude.text = String(format:"%.2f%", (locations.last?.coordinate.latitude)!) + "°"
        longitude.text = String(format:"%.2f%", (locations.last?.coordinate.longitude)!) + "°"
        altitude.text = String(format:"%.0f%", (locations.last?.altitude)!) + "m"
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

