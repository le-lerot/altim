//
//  MapViewController.swift
//  Altim
//
//  Created by Martin Delille on 23/12/2016.
//  Copyright © 2016 Phonations. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        self.mapView.showsScale = true
        
        // Add an annotation
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.69, longitude: 6.55)
        point.title = "Where am I?";
        point.subtitle = "I'm here!!!";
        
        self.mapView.addAnnotation(point)
        
        // register the Long Press Gesture Recognizer to the map
        let uilgr = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationToMap))
        uilgr.minimumPressDuration = 1.0
        self.mapView.addGestureRecognizer(uilgr)
    }
    
    func addAnnotationToMap(gestureRecognizer:UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinates
            mapView.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: location manager delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func centerMap(_ sender: Any) {
        self.mapView.setUserTrackingMode( MKUserTrackingMode.follow, animated: true)
    }

}

