//
//  ViewController.swift
//  CityWeather
//
//  Created by Arpit Kulshrestha on 05/04/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController
{
    @IBOutlet var city: UILabel!
    @IBOutlet var state: UILabel!
    
    @IBOutlet var temperature: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var humidity: UILabel!
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        WLocationManager.sharedInstance.setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.value(forKey: "State") != nil {
            state.text = (UserDefaults.standard.value(forKey: "State") as! String)
        }
        
        if UserDefaults.standard.value(forKey: "City") != nil {
            city.text = (UserDefaults.standard.value(forKey: "City") as! String)
            let address: String = city.text! + "," + state.text! + "," + "United States"
            //self.geocoding(address: address)
            WAPIManager.shared.getWeatherDataWith(city: city.text!, completionHandler: {(weather,error) in
                
                if error != nil {
                    print(error!)
                }
                else {
                    guard let weatherData = weather else {return}
                    if weatherData.list != nil {
                        if weatherData.list!.count > 0 {
                            DispatchQueue.main.async {
                                self.temperature.text = "Temperature:   " + String(weatherData.list![0].main!.temp)
                                self.pressure.text = "Pressure:  " + String(weatherData.list![0].main!.pressure)
                                self.humidity.text = "Humidity:  " + String(weatherData.list![0].main!.humidity)
                            }
        
                        }
                    }
                }
            })
        }
       
    }
    
    @IBAction func changeCity(_ sender: Any) {
        self.performSegue(withIdentifier: "chooseCity", sender: nil)
    }
    
    func geocoding(address: String) {
            let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: { [self] (placemarks, error) in
                if error != nil {
                    print("Failed to retrieve location")
                    return
                }
                
                var location: CLLocation?
                
                if let placemarks = placemarks, placemarks.count > 0 {
                    location = placemarks.first?.location
                }
                
                if let location = location {
                    let coordinate = location.coordinate
                    print("\nlat: \(coordinate.latitude), long: \(coordinate.longitude)")
                    self.latitude = coordinate.latitude
                    self.longitude = coordinate.longitude
                    
                    WAPIManager.shared.getWeatherData(lat: self.latitude, lon: self.longitude, completionHandler: {(weather,error) in
                        if error != nil {
                            print(error!)
                        }
                        else {
                            guard let weatherData = weather else {return}
                            if weatherData.list != nil {
                                if weatherData.list!.count > 0 {
                                    DispatchQueue.main.async {
                                        self.temperature.text = "Temperature:" + String(weatherData.list![0].main!.temp)
                                        self.pressure.text = "Pressure:" + String(weatherData.list![0].main!.pressure)
                                        self.humidity.text = "Humidity:" + String(weatherData.list![0].main!.humidity)
                                    }
                                }
                            }
                        }
                    })
                }
                else
                {
                    print("No Matching Location Found")
                }
            })
        }
    
    


}

