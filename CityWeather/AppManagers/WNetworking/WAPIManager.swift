//
//  WAPIManager.swift
//  CityWeather
//
//  Created by Arpit Kulshrestha on 05/04/23.
//

import Foundation

class WAPIManager {
    static let shared = WAPIManager()
    private init(){}
    
    func getWeatherData(lat: Double, lon: Double, completionHandler: @escaping(WeatherDataModel?, Error?) -> Void) {
        
        guard let url = URL(string: WAppConstants.baseURL + WAppConstants.lat + String(lat) + WAppConstants.lon + String(lon) + WAppConstants.appid + WAppConstants.APIKEY) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            if let error = error {
                completionHandler(nil, error)
            }
            
            guard let data1 = data else {return}
            do {
                let apiResult = try JSONDecoder().decode(WeatherDataModel.self, from: data1)
                completionHandler(apiResult, nil)
            }
            
            catch {
                print(error)
                completionHandler(nil, error)
            }
        }).resume()
    }
    
    func getWeatherDataWith(city: String, completionHandler: @escaping(WeatherDataModel?, Error?) -> Void) {
        
        guard let url = URL(string: WAppConstants.baseURL + WAppConstants.city + city + WAppConstants.appid + WAppConstants.APIKEY) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            if let error = error {
                completionHandler(nil, error)
            }
            
            guard let data1 = data else {return}
            do {
                let apiResult = try JSONDecoder().decode(WeatherDataModel.self, from: data1)
                completionHandler(apiResult, nil)
            }
            
            catch {
                print(error)
                completionHandler(nil, error)
            }
        }).resume()
    }
}
