//
//  ViewController.swift
//  CoreLocationDemo3
//
//  Created by Amanda Demetrio on 9/14/18.
//  Copyright © 2018 Amanda Demetrio. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let center = UNUserNotificationCenter.current()
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting up mapView
        mapView.showsPointsOfInterest = true
        mapView.showsCompass = true
        mapView.userTrackingMode = .follow
        
        //Setting up location manager
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self as CLLocationManagerDelegate
        let regionCenter = CLLocationCoordinate2D(latitude: 37.374445,longitude: -122.051891);
        monitorRegionAtLocation(center: regionCenter, identifier: "Home")
        
        let annotation = MKPointAnnotation()
        annotation.title = "Home"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.374445, longitude: -122.051891)
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func monitorRegionAtLocation(center: CLLocationCoordinate2D, identifier: String ) {
        print("got inside monitor region function")
        // Make sure the app is authorized.
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            print("has authorization to track location")
            // Make sure region monitoring is supported.
            if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
                print("has monitoring available")
                // Register the region.
                let radius = CLLocationDistance(10.0)
                print(radius)
                let region = CLCircularRegion(center: center,
                                              radius: radius, identifier: identifier)
                region.notifyOnEntry = true
                region.notifyOnExit = true
                locationManager.startMonitoring(for: region)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered region")
        statusLabel.text = "Entered monitored region"

    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("left region")
        statusLabel.text = "Left monitored region"
    }

}
