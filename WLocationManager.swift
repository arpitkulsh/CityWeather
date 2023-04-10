//
//  WLocationManager.swift
//  CityWeather
//
//  Created by Arpit Kulshrestha on 05/04/23.
//

import Foundation
import UIKit
import CoreLocation

class WLocationManager: NSObject, UIAlertViewDelegate, CLLocationManagerDelegate
{
    // MARK:- VARIABLES
    var locationManager : CLLocationManager!
    var userLocation: CLLocation?
    var kMinUpdateDistance = 5.0
    var updateTimer : Timer? = nil
    
    static let sharedInstance: WLocationManager = {
        let instance = WLocationManager()
        return instance
    }()
    
    override init() {
        super.init()
    }
    
    /*
     Setting up Location Manager Properties
     - type, filter, accuracy, enabled check
     */
    func setupLocationManager()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.activityType = CLActivityType.automotiveNavigation
        locationManager.distanceFilter = kMinUpdateDistance
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = false
        if CLLocationManager.locationServicesEnabled() {
            requestLocationAuthorization()
            
        }
    }
    
    /*
     Check GPS Setting Status
     - Always, WhenIn Use , Not Determoned etc
     
     */
    func requestLocationAuthorization()
    {
        // Get the current location permissions
        let status = locationManager.authorizationStatus

        // Handle each case of location permissions
        switch status {
            case .authorizedAlways:
                print("")
            locationManager.requestLocation()
            case .authorizedWhenInUse:
            print("")
            locationManager.requestLocation()
            case .denied:
            print("")
            case .notDetermined:
            print("")
            locationManager.requestLocation()
            case .restricted:
            print("")
        @unknown default:
            print("")
        }
    }
        
        /*
         Trigger to start GPS Location Tracking
         
         */
        func startTracking()
        {
            locationManager.startUpdatingLocation()
        }
        
        /*
         Trigger to stop GPS Location Tracking
         
         */
        func stopTracking()
        {
            locationManager.stopUpdatingLocation()
            if (updateTimer != nil) {
                updateTimer!.invalidate()
                updateTimer = nil
            }
        }
        
        
        
        // Request Location Update
        func forceUpdateLocation() {
            locationManager.requestLocation()
        }
      
        
        /*
         Check for location is enabled or not and return red / green globe image
         as per required by home controller
         */
        func checklocationEnabled() -> UIImage
        {
            if CLLocationManager.locationServicesEnabled()
            {
                switch CLLocationManager.authorizationStatus()
                {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                    return UIImage(named: "RedGPS")!
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                    return UIImage(named: "GreenGPS")!
                default:
                    print("Access")
                    return UIImage(named: "GreenGPS")!
                }
            } else {
                print("Location services are not enabled")
                return UIImage(named: "RedGPS")!
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
        {
            if status == CLAuthorizationStatus.authorizedAlways
            {
                locationManager.startUpdatingLocation()
                locationManager.startMonitoringSignificantLocationChanges()
                
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            userLocation = locationManager.location
            print("userLocation \(String(describing: userLocation))")
        }
        
        public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
        {
            print("LocationTracker: didFailWithError \(error)")
            if locationManager.location?.coordinate == nil
            {
                userLocation = CLLocation.init(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
            }
        }
}
    
    
    
    
